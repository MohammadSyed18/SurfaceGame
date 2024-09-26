# Surface Game

A GameMaker submarine game with buoyancy, underwater movement, solid obstacles, and spike recovery. Open `SurfaceGAME.yyp` in GameMaker.

The submarine controller uses frame-time scaling, bounded collision substeps, collision-box room limits, and a brief recovery cooldown. Movement is calibrated to a 60 Hz reference frame, with lag compensation capped to prevent large jumps.
