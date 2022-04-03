extends Node

# Contains the global information about the current level.

export var money = 1000
export var distance = 0
export var targetDistance = 100

var player: Player

func _ready():
    setup()

func setup():
    if get_tree().get_nodes_in_group('player').size() <= 0:
        return

    player = get_tree().get_nodes_in_group('player')[0]
    player.connect('player_moved', self, '_onPlayerMoved')
    player.connect('player_collision', self, '_onPlayerCollided')

    money = rand_range(800, 8000)
    distance = 0
    targetDistance = money * rand_range(.4, .9)


func _process(_delta):
    if distance >= targetDistance:
        # level complete
        # TODO
        GameController.levelComplete()

    if player and is_instance_valid(player) and money <= 0:
        if player.has_method('destroyPlayer'):
            player.destroyPlayer()


func _onSceneChange():
    setup()

func _onPlayerMoved(delta):
    distance += delta

func _onPlayerCollided(amount):
    # TODO: this should decrease with armor and increase with difficulty
    money -= amount * 3.2

func _onCarSpinned():
    money += rand_range(5, 20)

func _onCarDestroyed():
    money += rand_range(20, 80)

