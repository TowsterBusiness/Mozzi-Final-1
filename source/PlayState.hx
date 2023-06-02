package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.addons.display.shapes.FlxShapeLine;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class PlayState extends FlxState
{
	var xMove:Int = 0;
	var yMove:Int = 0;
	var player:FlxShapeBox;
	var grid:FlxTypedGroup<FlxShapeBox>;

	var lines:FlxTypedGroup<FlxShapeBox>;

	var start:FlxShapeBox;
	var cp1:FlxTypedGroup<FlxShapeBox>;
	var cp2:FlxTypedGroup<FlxShapeBox>;

	override public function create()
	{
		grid = new FlxTypedGroup<FlxShapeBox>(100);
		for (w in 1...8)
		{
			var line = new FlxShapeBox(w * 100, 100, 3, 500, {}, 0xFFFFFFFF);
			grid.add(line);
		}
		for (h in 1...8)
		{
			var line = new FlxShapeBox(100, h * 100, 500, 3, {}, 0xFFFFFFFF);
			grid.add(line);
		}
		add(grid);

		lines = new FlxTypedGroup<FlxShapeBox>(100);
		add(lines);

		start = new FlxShapeBox(120, 120, 60, 60, {color: 0x00000000}, 0xFFC869E5);
		add(start);

		player = new FlxShapeBox(125, 125, 50, 50, {color: 0x00000000}, 0xFF7FD2DA);
		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.anyJustPressed([UP, DOWN, RIGHT, LEFT]))
		{
			var oxMove:Int = xMove;
			var oyMove:Int = yMove;
			var wf = 10;
			var hf = 10;
			var xd = 150;
			var yd = 150;
			if (FlxG.keys.justPressed.UP)
			{
				yMove -= 1;
				hf = 110;
				yd = 50;
			}
			else if (FlxG.keys.justPressed.DOWN)
			{
				yMove += 1;
				hf = 110;
			}
			else if (FlxG.keys.justPressed.RIGHT)
			{
				xMove += 1;
				wf = 110;
			}
			else if (FlxG.keys.justPressed.LEFT)
			{
				xMove -= 1;
				wf = 110;
				xd = 50;
			}

			if (xMove >= 6 || yMove >= 6 || xMove < 0 || yMove < 0)
			{
				xMove = oxMove;
				yMove = oyMove;
			}

			player.x = xMove * 100 + 125;
			player.y = yMove * 100 + 125;

			lines.add(new FlxShapeBox(oxMove * 100 + xd, oyMove * 100 + yd, wf, hf, {color: 0xFFFFFFFF, thickness: 2}, 0xFFFFFFFF));
		}

		if (FlxG.keys.justPressed.F1)
		{
			switchTo(new PlayState());
		}

		super.update(elapsed);
	}
}
