# RaineTween
RaineTween is a client tweening system for Roblox which allows for smooth tweens.
By moving the responsibility of tweening from the server to the client, it allows for a [much smoother tween](https://devforum.roblox.com/t/tweening-on-the-client/1472967/4).

RaineTween currently supports the methods provided by TweenService.

> [!NOTE]
> RaineTween probably isnt very optimized.
> 
> If you notice a possible performance issue, stupid thing in my code, or a memory leak, and know how to fix it, please notify me immediately.

## Installation

### Roblox
Currently, RaineTween has no direct installation method from Roblox. Use the Github method instead.

### Github
* Create a ModuleScript wherever you need it, although I reccommend placing it as a descendant of `ServerStorage`.
* Then create a LocalScript in `StarterPlayerScripts`.
* Copy the scripts from [`/src/`](https://github.com/raineyraine/RaineTween/tree/main/src) into the scripts you just created.

![image](https://github.com/user-attachments/assets/2a263c66-6c0c-4bfb-8f5b-802bea3f7872)

## Documentation
> [!NOTE]
> Documentation is incomplete. Do not use at the moment.

### TweenObject
The `TweenObject` class is the server-side reference to a clientside Tween. It acts as an interface to the clients running the tween.

#### Properties
##### TweenId: string `Read Only`
The ID of the TweenObject, which is used by clients for reference. Currently is created by `tostring(os.clock())`.

##### TweenInfo: TweenInfo `Read Only`
The `TweenInfo` used when creating the TweenObject.

##### ConvertedTweenInfo: {} `Read Only`
A converted form of the `TweenInfo` used when creating the TweenObject. Utilitized by clients as `TweenInfo` isn't replicated.

##### Instance: Instance `Read Only`
A reference to the Instance that the TweenObject acts on.

##### PlaybackState: Enum.PlaybackState `Read Only`
The current state of the Tween. See `Enum.PlaybackState` for more information.

#### Methods

#### Events
##### Completed
Fired when `TweenObject:Cancel()` is called or when the Tween ends.
| Parameters                        |                                                        |
|-----------------------------------|--------------------------------------------------------|
| playbackState: Enum.PlaybackState | The `Enum.PlaybackState` of the tween upon completion. |
##### Destroying
Fires when the TweenObject is about to be destroyed.
