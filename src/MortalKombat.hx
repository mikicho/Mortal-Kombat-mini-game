
import pixi.plugins.app.Application;
import js.Browser;

class MortalKombat extends Application {
    public static var playing;
    var _gameScene:GameScene;

    public function new() {
		super();
        
        position = "fixed";
		super.start(Application.AUTO);
        
		LoaderSingleton.getInstance().add("fighter", "player/fighter.json");
        _gameScene = new GameScene();

        LoaderSingleton.getInstance().load(_onLoaded);
    }

    function _onLoaded() {
        _gameScene.init();
        stage.addChild(_gameScene);        
        playing = true;
        animate();
    }

    function animate (time = null) {
        Browser.window.requestAnimationFrame(animate);
        renderer.render(stage);
    }
}