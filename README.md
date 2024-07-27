> [!NOTE]
> This is an experimental branch. It is a future version of RaineTween which supports RealTweens, a way for the server to use all Tween methods despite the tween existing on the client.
> # RaineTween
RaineTween is a client tweening system for Roblox which allows for smooth tweens.
By moving the responsibility of tweening from the server to the client, it allows for a [much smoother tween](https://devforum.roblox.com/t/tweening-on-the-client/1472967/4).

RaineTween is meant to be backwards compatible with Roblox's existing `TweenService`, and `TweenObjects` will behave exactly the same except with added functionality.

> [!NOTE]
> RaineTween probably isnt very optimized.
> 
> If you notice a possible performance issue, stupid thing in my code, or a memory leak, and know how to fix it, please notify me immediately.

# Installation

## Roblox
Currently, RaineTween has no direct installation method from Roblox. Use the Github method instead.

## Github
* Create a ModuleScript wherever you need it, although I reccommend placing it as a descendant of `ServerStorage`.
* Then create a LocalScript in `StarterPlayerScripts`.
* Copy the scripts from [`/src/`](https://github.com/raineyraine/RaineTween/tree/main/src) into the scripts you just created.

![image](https://github.com/user-attachments/assets/2a263c66-6c0c-4bfb-8f5b-802bea3f7872)
