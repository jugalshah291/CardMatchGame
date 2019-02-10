package;

import flixel.addons.nape.FlxNapeSprite;
import flixel.addons.nape.FlxNapeSpace;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import nape.constraint.DistanceJoint;
import nape.dynamics.InteractionFilter;
import nape.geom.Vec2;
import nape.phys.Body;
import flixel.util.FlxTimer;

import flixel.system.FlxSound;

class Card extends FlxNapeSprite
{

	static inline var TURNING_TIME:Float = 0.2;
	
	var turned:Bool = false;

	public var cardIndex:Int;
	public var cardType:String;

	public function new(x:Float, y:Float, cardIndex:Int, cardType:String):Void
	{
		super(x, y);
		this.cardIndex = cardIndex;
		this.cardType=cardType;
		loadGraphic("assets/images/Deck.png", true, 79, 123);
	
		
		animation.frameIndex = 54;
		
		antialiasing = true;
		setDrag(0.95, 0.95);
	
		createRectangularBody(25, 25);
		
		body.setShapeFilters(new InteractionFilter(2, ~2));
		
	
		
	}

	public function display(i:Int){
		if(i==0){
			animation.frameIndex = cardIndex;
			turned= false;
			FlxG.sound.play("assets/sounds/cardOpen.wav");

		}
		else{
			animation.frameIndex = 54;
			turned= false;
			FlxMouseEventManager.add(this, onDown, null, onOver, onOut);
			FlxG.sound.play("assets/sounds/cardOpen.wav");

		}
		FlxTween.tween(scale, { x: 1 }, TURNING_TIME / 2);

	}
	
	function onDown(_)
	{
		
		if (!turned)
		{
			turned = true;
			FlxTween.tween(scale, { x: 0 }, TURNING_TIME / 2, { onComplete: pickCard });
		}
		
	}
	
	function onOver(_)
	{
		color = 0x00FF00;
	}
	
	function onOut(_)
	{
		color = FlxColor.WHITE;
	}
	
	function pickCard(_):Void
	{
		

		animation.frameIndex = cardIndex;


		if(cardType=="questionCard"){

			FlxTween.tween(scale, { x: 1 }, TURNING_TIME / 2);
			PlayState.isquestionCardOpen=1;
			PlayState.questionCard=this;
			FlxG.sound.play("assets/sounds/cardOpen.wav");
		}
		
		
		else if(cardType=="ansCard" && PlayState.isquestionCardOpen==1){
			FlxG.sound.play("assets/sounds/cardOpen.wav");
			FlxTween.tween(scale, { x: 1 }, TURNING_TIME / 2);	
			new FlxTimer().start(1,function(timer){

				if(PlayState.questionCard.cardIndex!=cardIndex){

					PlayState.blackscreen.visible = true;
					PlayState.gameoverText.visible = true;
					FlxG.sound.play("assets/sounds/GameOver.wav");
					new FlxTimer().start(0.5, function (timer)
					{
						FlxG.switchState(new MenuState());
						//FlxG.resetState();
					});
					}
				else{ 
					PlayState.cardcount+=1;
					PlayState.questionCard.kill();
					this.kill();
					if(PlayState.cardcount>=12){
						PlayState.blackscreen.visible = true;

						PlayState.gamewinText.visible = true;
						FlxG.sound.play("assets/sounds/applause_y.wav");
						new FlxTimer().start(1, function (timer)
						{
						FlxG.switchState(new MenuState());
						//FlxG.resetState();
						});
					
					}
					PlayState.isquestionCardOpen=0;


				}
		});

		}
		else{
			animation.frameIndex = 54;
			turned= false;
			FlxTween.tween(scale, { x: 1 }, TURNING_TIME / 2);

		}


		
	}
	
	override public function destroy():Void
	{

		FlxMouseEventManager.remove(this);
		super.destroy();
	}
}
