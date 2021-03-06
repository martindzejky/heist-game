extends Control

export var shownValue = 0
var counter = 0
var previousDiff = 0

func _process(delta):
    shownValue = round(shownValue)
    var currentValue = max(0, round(LevelProgress.money))
    var diff = currentValue - shownValue

    # reset the shown value when the counter is more than a few seconds
    if counter > 1 or abs(diff) > 1000:
        counter = 0
        # shownValue = currentValue
        $tween.interpolate_property(self, 'shownValue', shownValue, currentValue, .5)
        $tween.start()

    if is_equal_approx(diff, 0):
        $text/diff.visible = false
    else:

        # move the counter if the diff stays on the same number
        if is_equal_approx(previousDiff, diff):
            counter += delta
        else:
            counter = 0

        $text/diff.visible = true
        $text/diff.text = str(diff)

        if diff > 0:
            $text/diff.text = '+' + $text/diff.text
            $text/diff.add_color_override('font_color', Color.green)
        else:
            $text/diff.add_color_override('font_color', Color.red)



    $text.text = str(shownValue)
    previousDiff = diff
