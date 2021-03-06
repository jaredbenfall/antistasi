#include "macros.hpp"

params ["_string"];
private _ar_start_count = count AR_START;
private _ar_end_count = count AR_END;
private _ob_start_count = count OB_START;
private _ob_end_count = count OB_END;

private _deserialize_single = {
    params ["_type", "_value_string"];
    private _value = "";
    if (_type == "OB") then {
        _value = call EFUNC(create);
        _value_string = _value_string select [_ob_start_count, count _value_string - _ob_start_count - _ob_end_count];
        if (_value_string == "") exitWith {};
        {
            [_value, _x] call _deserialize;
        } forEach ([_value_string, SEPARATOR, OB_START, OB_END] call EFUNC(_splitString));
    };
    if (_type == "AR") then {
        _value_string = _value_string select [_ar_start_count, count _value_string - _ar_start_count - _ar_end_count];
        _value = [];
        if (_value_string == "") exitWith {};
        {
            private _bits = _x splitString ":";

            private _final_bit = _bits select 2;
            for "_i" from 3 to (count _bits - 1) do {
                _final_bit = _final_bit + ":" + (_bits select _i);
            };

            if (_final_bit == (AR_START + AR_END)) then {
                _value pushBack [];
            } else {
                _value pushBack ([_bits select 1, _final_bit] call _deserialize_single);
            };
        } forEach ([_value_string, ",", AR_START, AR_END] call EFUNC(_splitString));
    };
    if (_type == "BO") then {
        _value = [True, False] select (_value_string == "false");
    };
    if (_type == "ST") then {
        _value = _value_string select [1, count _value_string - 2];
    };
    if (_type == "SC") then {
        _value = parseNumber _value_string;
    };
    if (_type == "TE") then {
        _value = text _value_string;
    };
    _value
};

private _deserialize = {
    params ["_dictionary", "_string"];
    private _bits = _string splitString ":";

    private _key = _bits select 0;

    if (count _bits == 2) then {
        [_dictionary, _key] call EFUNC(add);
        [_dictionary, _key, [_dictionary, _bits select 1] call _deserialize] call EFUNC(add);
    } else {
        private _final_bit = _bits select 2;
        for "_i" from 3 to (count _bits - 1) do {
            _final_bit = _final_bit + ":" + (_bits select _i);
        };

        private _value = [_bits select 1, _final_bit] call _deserialize_single;
        [_dictionary, _key, _value] call EFUNC(set);
    };
};
["OB", _string] call _deserialize_single
