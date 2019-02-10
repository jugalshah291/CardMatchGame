package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;
import flixel.math.FlxVelocity;
import flixel.util.FlxColor;

class MenuState extends FlxState
{

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}

	var _btnPlay:FlxButton;
	override public function create():Void
	{
		add(new FlxSprite(0, 0, "assets/images/background.jpg"));

		var title=new FlxText(FlxG.width/2,50,FlxG.width, "The Joker");
		title.x=FlxG.width/2-title.width/2;
		title.setFormat("assets/data/font.ttf",100, FlxColor.GREEN,"center");
		add(title);

		_btnPlay = new FlxButton(5, 5, "", clickPlay);
		_btnPlay.loadGraphic("assets/images/Play.png");
		_btnPlay.screenCenter();
		add(_btnPlay);
	
		super.create();	
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
