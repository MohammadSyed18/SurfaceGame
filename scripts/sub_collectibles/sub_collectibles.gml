function sub_collect_one(_object, _value) {
    var _item = instance_place(x, y, _object);
    if (_item == noone) return false;
    instance_destroy(_item);
    if (combo_time > 0) combo += 1; else combo = 1;
    combo_time = 4;
    var _earned = _value * min(combo, 5);
    score += _earned;
    collected += 1;
    oxygen = min(oxygen_capacity, oxygen + 8);
    message = "+" + string(_earned) + " · " + string(combo) + "x collection chain";
    message_time = 1.5;
    return true;
}

function sub_update_collectibles(_dt) {
    combo_time = max(0, combo_time - _dt);
    if (combo_time <= 0) combo = 0;
    sub_collect_one(oDiamond, 50);
    sub_collect_one(oDiamondA, 75);
    if (!level_complete && total_collectibles > 0 && collected >= total_collectibles) {
        level_complete = true;
        score += health * 100 + floor(oxygen);
        message = "All diamonds recovered! Press R for another dive.";
        message_time = 60;
        sub_save_best();
    }
}
