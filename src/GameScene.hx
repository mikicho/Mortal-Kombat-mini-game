
import pixi.core.sprites.Sprite;
import pixi.core.textures.Texture;
import js.Browser;
import js.html.KeyboardEvent;

class GameScene extends Scene {

    public static var _levels:Array<Level>;

    var _material:Sprite;
    var _fighter:Fighter;
    var _bar:PowerBar;
    var _currentLevel:Int;
    var _altarText:Sprite;    

    public function new() {
        super();

        _levels = new Array<Level>();
        setLevels();
        
        //TODO: Add all images to cache
		LoaderSingleton.getInstance().add("materials", "materials/materials.json");
    }

    function setLevels() {
        _levels.push({name:"wood"       , threshold:Math.floor(PowerBar.maxHight * 0.25)});
        _levels.push({name:"stone"      , threshold:Math.floor(PowerBar.maxHight * 0.4)});
        _levels.push({name:"steel"      , threshold:Math.floor(PowerBar.maxHight * 0.5)});
        _levels.push({name:"ruby"       , threshold:Math.floor(PowerBar.maxHight * 0.75)});
        _levels.push({name:"diamond"    , threshold:Math.floor(PowerBar.maxHight * 0.9)});
    }

    public function init() {
        Browser.document.addEventListener("keydown", handleKeyPress, true);

        var background = new Sprite(Texture.fromImage("assets/screens/main_screen.png"));
        addChild(background);

        var instructionsText = new Sprite(Texture.fromImage("assets/texts/instructions.png"));
        instructionsText.position.set(315, 20);
        addChild(instructionsText);

        _fighter = new Fighter();
		_fighter.getFighter().anchor.set(0.5, 1);
		_fighter.getFighter().position.set(330, 520);
        addChild(_fighter.getFighter());

        _material = new Sprite();
        _material.position.set(315, 588);
		_material.anchor.set(0.5, 1);        
        addChild(_material);
        
        _altarText = new Sprite();
        _altarText.position.set(315, 690);
		_altarText.anchor.set(0.5, 1);        
        addChild(_altarText);

        _bar = new PowerBar();
        _bar.position.set(60, 100);
        addChild(_bar);

        loadLevel(0); 
    }

    function loadLevel(level:Int) {
        _currentLevel = level; 
        _bar.setDifficulty(level);
        resetScene();
        MortalKombat.playing = true;      
    }

    function resetScene() {
        _material.texture = Texture.fromFrame(_levels[_currentLevel].name + ".png");
        _altarText.texture = Texture.fromFrame(_levels[_currentLevel].name + "_word.png");
        _bar.getBar().height = 0;
        _bar.start(); 
		_fighter.getFighter().play();                
    }

    function handleKeyPress(e:KeyboardEvent) {  
        switch(e.keyCode) {
            case KeyboardEvent.DOM_VK_DOWN:    
                MortalKombat.playing = false;
                _fighter.setChopTexture(decideResult);
                _bar.stop();
        }  
    }


    function decideResult() {
        if (_levels[_currentLevel].threshold < _bar.getBar().height) {
            _material.texture = Texture.fromFrame(_levels[_currentLevel].name + "_broken.png");  
            _altarText.texture = Texture.fromImage("assets/texts/excellent.png");  
            if (_currentLevel < _levels.length) {
                haxe.Timer.delay(function() {
                    loadLevel(++_currentLevel);
                }, 3 * 1000);  
            }   
        }
    }
}