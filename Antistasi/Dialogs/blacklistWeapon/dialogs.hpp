class BlacklistWeapon
{
    idd = 1602; 
    movingEnable = false; 

    class Controls 
    {
        AS_DIALOG(5, "Blacklist Weapon", "closeDialog 0;");
        LIST_L(0,1,0,4,"");
        BTN_R(5, 4, "Toggle blacklisted", "", "[] call AS_fnc_UI_blacklistWeapon_updateBlacklist;");
    };
};



/* Hello world dialog 
class BlacklistWeapon
{
    idd = -1; 
    movingEnable = false;
    enableSimulation = true; 
    controlsBackground[] = { }; 
    objects[] = { }; 
    controls[] = { MyHelloText }; 

    class MyHelloText 
    {
        idc = -1; 
        moving = 0;
        type = CT_STATIC;
        style = ST_LEFT;
        text = "Hello world!";
        font = "PuristaSemiBold";
        sizeEx = 0.023;

        colorBackground[] = { 1, 1, 1, 0.3 }; 
        colorText[] = { 0, 0, 0, 1 };

        x = 0.8;
        y = 0.1; 
        w = 0.2; 
        h = 0.05; 
    };
};
*/