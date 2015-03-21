/*
 * Author: CAA-Picard
 * Check if the player can check the ammo of the target.
 *
 * Argument:
 * 0: Player <OBJECT>
 * 1: Target <OBJECT>
 *
 * Return value:
 * Can link belt<BOOL>
 */
#include "script_component.hpp"

EXPLODE_2_PVT(_this,_player,_target);

// Return true for static weapons if they have been fired once, @todo 1.40 this work-around doesn't work anymore
if (_target isKindOf "StaticWeapon") exitWith {
	(currentMagazine _target) != ""
};

// Return false for all other vehicles
if !(_target isKindOf "CAManBase") exitWith {false};

// For men
if (currentWeapon _target == "") exitWith {false};

// Check if their current magazine is a belt
_magazineType = currentMagazine _target;
_magazineCfg = configFile >> "CfgMagazines" >> _magazineType;
if (getNumber (_magazineCfg >> "ACE_isBelt") == 1) exitWith {true};

// Check for rocket launchers
if (currentWeapon _target == secondaryWeapon _target) exitWith {true};

false
