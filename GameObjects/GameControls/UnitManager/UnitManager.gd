extends Node2D

var miners = {"player" : []}
var transports = {"player" : []}
var bases = {"player" : []}
var miningJobs = {"player" : []}
var transportsJobs = {"player" : []}

var jobs = {}
enum JobTypes {
  MINING, #Used for Mining Asteroids
  TRANSPORT, #Used for moving goods from determined location to destination that can use it
  SUPPLY, #Used for bringing goods 	from nears available locations that store goods to destination 
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Unit Manager Ready")
	var jobList = {}
	for job in JobTypes:
		jobs[JobTypes[job]] = []
	

func init_initial_units():
	var station = load("res://GameObjects/Stations/Starbase/Starbase.tscn")
	add_child(station.instance())
	var miner = load("res://GameObjects/Ships/Miner/Miner.tscn")
	add_child(miner.instance())
	add_child(miner.instance())
	add_child(miner.instance())
	var transport = load("res://GameObjects/Ships/Transport/Transport.tscn")
	add_child(transport.instance())
	#add_child(transport.instance())

func registerMiner(object, owner):
	miners[owner].append(object)

func registerTransport(object, owner):
	transports[owner].append(object)

func registerBase(object, owner):
	print("Register base")
	bases[owner].append(object)

func createJob(data):
		jobs[data.type].append(data)
		
func createMinJob(object, owner):
	miningJobs[owner].append(object)

func getJob(types):
	for type in types:
		if jobs[type].size() > 0:
			return jobs[type].pop_front()
	return null
		
func getMinerJob(owner):
	if miningJobs[owner].size() > 0:
		return miningJobs[owner].pop_front()
	else:
		return null

func findNearestBase(position, owner):
	var nearest = null
	var distance = null
	for base in bases[owner]:
		if distance == null || distance < base.distance_to(position):
			nearest = base
	return nearest
	
func findNearestBaseWithResource(position, owner, resource, amount):
	var nearest = null
	var distance = null
	for base in bases[owner]:
		if (distance == null || distance < base.distance_to(position)) && base.getInventory().hasInventory(resource, amount):
			nearest = base
	return nearest
	
func findNearestBaseToProcessResource(position, resource):
	var nearest = null
	var distance = null
	for base in bases["player"]:
		if (distance == null || distance < base.distance_to(position)) && base.doesProcess(resource):
			nearest = base
	return nearest
