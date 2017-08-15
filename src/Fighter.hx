
import pixi.core.textures.Texture;
import pixi.extras.AnimatedSprite;

class Fighter {
    var _fighter:AnimatedSprite;
    var _fighterBreathTexture = [];
    var _fighterChopTexture = [];

    public function new() {
        for (i in 1 ... 5) {
			_fighterBreathTexture.push(Texture.fromFrame("breath" + i + ".png"));
        }

        for (i in 1 ... 4) {
			_fighterChopTexture.push(Texture.fromFrame("chop" + i + ".png"));
        }

        _fighter = new AnimatedSprite(_fighterBreathTexture);
        _fighter.animationSpeed = 0.1;
    }

    public function getFighter() {
        return _fighter;
    }

    public function setBreathTexture() {
        _fighter.textures = _fighterBreathTexture;
        trace(_fighter);
        _fighter.loop = true;
        _fighter.play();
    }

    public function setChopTexture(onComplete) {
        _fighter.textures = _fighterChopTexture;
        _fighter.loop = false;
        _fighter.onComplete = onComplete;
        _fighter.play();        
    }
}