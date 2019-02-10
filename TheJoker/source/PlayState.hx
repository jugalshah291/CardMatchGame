package;

import flixel.addons.nape.FlxNapeSpace;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEventManager;
import nape.constraint.DistanceJoint;
import nape.geom.Vec2;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

class PlayState extends FlxState
{

		var x_pos=100;
		var y_pos=100;
		public static var cardJoint:DistanceJoint;
		//public static var arrayOfCard=[];
		public static var lastCard:Int;
		public static var questionCard:Card;
		public static var isquestionCardOpen=0;
		public static var flag=0;
		public static var cardcount=0;
		public static var blackscreen:FlxSprite;
	    public static var resetText:FlxText;
	    public static var gameoverText:FlxText;
	    public static var gamewinText:FlxText;

		
			override public function create():Void
	{
		super.create();
		cardcount=0;
		FlxG.sound.play("assets/sounds/background.wav",0.15,true);
		FlxNapeSpace.init();

		resetText=new FlxText(0,FlxG.height/2-50, FlxG.width, "RESTARTING...");
		resetText.setFormat("assets/data/font.ttf",50, FlxColor.GREEN,"center");
		resetText.visible = false;

		gameoverText=new FlxText(0,FlxG.height/2-50, FlxG.width, "GAME OVER ");
		gameoverText.setFormat("assets/data/font.ttf",50, FlxColor.RED,"center");
		gameoverText.visible = false;

		gamewinText=new FlxText(0,FlxG.height/2-50, FlxG.width, "YOU WON ");
		gamewinText.setFormat("assets/data/font.ttf",50, FlxColor.GREEN,"center");
		gamewinText.visible = false;

		blackscreen = new FlxSprite(0,0);
		blackscreen.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackscreen.visible = false;


		add(new FlxSprite(0, 0, "assets/images/background.jpg"));
		

		FlxG.plugins.add(new FlxMouseEventManager());
		


		add(createCards());
		add(blackscreen);
		add(resetText);
		add(gameoverText);
		add(gamewinText);
		FlxNapeSpace.createWalls();
		


	}
	function createCards():FlxTypedGroup<Card>
	{
		var cards = new FlxTypedGroup<Card>();
		var pickedCards = [];
		var pickedquestionedCards=[];

		function createCardStack(amount:Int, start:FlxPoint, offset:FlxPoint,questionCards:Int)
		{
			var x = start.x;
			var y = start.y;

			for (i in 0...amount)
			{
				
				if(questionCards==0)
				{
				
				if(i%4==0 && i!=0){

					x =start.x;

					y += offset.y;
				}
				else if(i!=0){
					x += offset.x;
				}
				
				var pick = FlxG.random.int(0, 51, pickedCards);

				pickedCards.push(pick);
				
				cards.add(new Card(x, y, pick,"ansCard"));


				}
				else{
				
					var k=pickedCards.length;

					var questioncardIndex=FlxG.random.int(0,k-1,pickedquestionedCards);
					pickedquestionedCards.push(questioncardIndex);

					cards.add(new Card(x,y,pickedCards[questioncardIndex],"questionCard"));
				
					
					x += offset.x;
					y += offset.y;
				
				}

			}
		}


		createCardStack(12, FlxPoint.get(250, 75), FlxPoint.get(100, 150),0);
		cards.forEach(function(t)
		{
			t.display(0);

		},false);


		new FlxTimer().start(10,function(timer){
			cards.forEach(function(t)
		{
			t.display(1);

		},false);
		});

		createCardStack(12, FlxPoint.get(100,FlxG.height/2), FlxPoint.get(2, -2),1);

		return cards;
	}


	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);


		if (FlxG.keys.justReleased.R)
		{

			blackscreen.visible = true;
			resetText.visible = true;

			new FlxTimer().start(2, function (timer)
			{
			FlxG.resetState();
			});
		}
		

		
	}
}