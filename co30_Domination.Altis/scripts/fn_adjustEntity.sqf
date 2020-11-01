/**
 * Place _entity at _pos with an offset of 0.2 meter vertical
 * by TeTeT
 */

params ["_entity", "_pos"];

// height adjustment to move above the flight deck, otherwise some helos explode
_entity setPosASL (_pos vectorAdd 0.2);
_entity;
