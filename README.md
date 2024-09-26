# Surface Game

A GameMaker submarine game with buoyancy, underwater movement, solid obstacles, and spike recovery. Open `SurfaceGAME.yyp` in GameMaker.

The submarine controller uses frame-time scaling, bounded collision substeps, collision-box room limits, and a brief recovery cooldown. Movement is calibrated to a 60 Hz reference frame, with lag compensation capped to prevent large jumps.

## Gameplay modules

- [sub_motion](scripts/sub_motion/sub_motion.gml): frame-scaled movement, per-axis collision substeps, sprite-aware room limits.
- [sub_resources](scripts/sub_resources/sub_resources.gml): oxygen, surface recovery, checkpoints, hull damage, respawn protection, local best scores.
- [sub_collectibles](scripts/sub_collectibles/sub_collectibles.gml): diamond collection, timed chains, score multipliers, and completion bonuses.
- [sub_hud](scripts/sub_hud/sub_hud.gml): GUI oxygen bar, score/hull/diamond counters, messages, and pause/game-over overlays.

Arrow keys move, C sets a checkpoint at the surface, P pauses, and R restarts the room. Air replenishes near the configured surface line; running out of air or touching spikes damages the hull. Diamonds restore some air, and collecting all room diamonds earns a completion bonus. Collection totals initialize on the first Step so all room objects have completed creation.

```sh
python tools/check_resources.py
```

The checker verifies registered assets, script files, submarine event registration, and helper references. It is not a GML compiler. Open the project in GameMaker for gameplay, collision-mask, GUI, room-layout, and packaging checks; that runtime is not installed in this workspace.

The implementation uses GameMaker's documented [instance collision lookup](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/instance_place.htm) and [instance destruction](https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/instance_destroy.htm) APIs.
