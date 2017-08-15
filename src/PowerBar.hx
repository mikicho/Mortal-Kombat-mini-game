
import pixi.core.graphics.Graphics;
import js.Browser;
import haxe.Timer;
import pixi.core.sprites.Sprite;
import pixi.core.textures.Texture;
import pixi.core.display.Container;
import js.html.KeyboardEvent;

class PowerBar extends Container {
    public static inline var maxHight = 480;
    public static inline var raiseTick = 25;

    var _border:Int;
    var _bar:Graphics;
    var _threshold:Sprite;
    var _interval:Timer;

    public function new() {
        super();

        _bar = new Graphics();
        _bar.beginFill(0xFEFE00);
        _bar.drawRect(0, 0, 80, 1);
        _bar.position.set(100, maxHight);
        _bar.rotation = Math.PI;
        _bar.endFill();
        addChild(_bar);

        var barBorder = new Sprite(Texture.fromImage("assets/power_bar/barBorder.png"));
        barBorder.anchor.set(1, 1);
        barBorder.position.set(105, maxHight + 5);
        addChild(barBorder);

        _threshold = new Sprite(Texture.fromImage("assets/power_bar/threshold.png"));
        _threshold.anchor.set(0, 0.5);
        _threshold.position.x = 23;    
        addChild(_threshold);

        Browser.document.addEventListener("keyup", handleKeyPress, true);
    }

    public function setDifficulty(level:Int) {
        _interval = new haxe.Timer(Math.floor(50 / ((level + 1) / 2)));        
        _threshold.position.y = maxHight - GameScene._levels[level].threshold; 
    }

    public function start() {
        _interval.run = function () {
            if (_bar.height > 0) {
                _bar.height -=5;            
            }
        }
    }
    public function stop() {
        _interval.stop();
    }    

    public function raiseBar() {
        if (_bar.height + raiseTick < maxHight && MortalKombat.playing) {
            _bar.height += raiseTick;
        }
    }

    public function getBar() {
        return _bar;
    }

    function handleKeyPress(e:KeyboardEvent) {
        switch(e.keyCode) {
            case KeyboardEvent.DOM_VK_SPACE:    
                raiseBar();
        }  
    }
}