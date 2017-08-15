
import pixi.loaders.Loader;

class LoaderSingleton {
    private static var _instance:Loader = null;

    private function new() {}

    public static function getInstance() {
        if(_instance == null) {
            _instance = new Loader();
		    _instance.baseUrl = "assets/";
        }

        return _instance;
    }
}