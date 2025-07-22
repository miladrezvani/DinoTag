extends Node

const broadcastPort : int = 9000
const gamePort      : int = 42069
const broadcastRate : float = 1.0

var udp: PacketPeerUDP
var timer: Timer
var peer: ENetMultiplayerPeer
var hostFlag: bool = false 

signal hostFound(ip:String, port:int)

func _ready() -> void:
	udp = PacketPeerUDP.new()
	
	udp.set_broadcast_enabled(true)
	var err := ERR_UNAVAILABLE
	if udp.has_method("listen"):
		print("listen")
		err = udp.listen(broadcastPort, "*")
	elif udp.has_method("bind"):
		print("bind")
		err = udp.bind(broadcastPort, "*")
	else:
		push_error("PacketPeerUDP has no listen() or bind() methods ", err)
		return
	timer = Timer.new()
	timer.wait_time = broadcastRate
	timer.one_shot = false
	add_child(timer)
	timer.start()
	timer.timeout.connect(onBroadcastTimer)
	
	set_process(true)
	
func onBroadcastTimer():
	if peer and hostFlag:
		var buf = PackedByteArray()
		buf.append_array([])
		var writer = StreamPeerBuffer.new()
		writer.put_u32(0xAFCE6434)
		writer.put_u16(gamePort)
		var packet = writer.data_array
		udp.set_dest_address("255.255.255.255", broadcastPort)
		udp.put_packet(packet)
		
func _process(_delta):
	while udp.get_available_packet_count() > 0:
		var packet = udp.get_packet()
		var fromIp = udp.get_packet_ip()
		var reader = StreamPeerBuffer.new()
		reader.data_array = packet
		if reader.get_u32() != 0xAFCE6434:
			continue
		var port = reader.get_u16()
		emit_signal("hostFound", fromIp, port)

func startServer():
	peer = ENetMultiplayerPeer.new()
	var err = peer.create_server(gamePort)
	if err != OK:
		push_error("Couldn’t start ENet server (%d)" % err)
		return
	multiplayer.multiplayer_peer = peer
	hostFlag = true
	var myId = multiplayer.get_unique_id()
	multiplayer.emit_signal("peer_connected", myId)
	print("Server started on port %d" % gamePort)
	
func startClient():
	if not is_connected("hostFound", Callable(self, "onHostFound")):
		connect("hostFound", Callable(self, "onHostFound"))
	print("Client ready, listening for host broadcasts")
	
func onHostFound(ip:String, port:int):
	if peer: 
		return
	peer = ENetMultiplayerPeer.new()
	var err = peer.create_client(ip, port)
	if err != OK:
		push_error("ENet client failed to connect to %s:%d (%d)" % [ip, port, err])
		return
	multiplayer.multiplayer_peer = peer
	print("Connected to server at %s:%d" % [ip, port])
