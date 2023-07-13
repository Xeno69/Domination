//Land_Shed_02_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_boxes=createSimpleObject["A3\Structures_F\Civ\Market\CratesShabby_F.p3d",[0,0,0]];
_can=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterPlastic_F.p3d",[0,0,0]];
_pbox=createSimpleObject["A3\Structures_F\Civ\Market\CratesPlastic_F.p3d",[0,0,0]];
_sack=createSimpleObject["A3\Structures_F\Civ\Market\Sack_F.p3d",[0,0,0]];
_shelf=createSimpleObject["A3\Structures_F\Furniture\Metal_rack_Tall_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_boxes,_can,_pbox,_sack,_shelf];
_b setVariable["PF",_f];

_pbox setPos(_b modelToWorld[1.4,-0.83,-.39]);_pbox setDir(_dir+180);
_can setPos(_b modelToWorld[-1.65,-.93,-.17]);_can setDir(_dir+90);
_sack setPos(_b modelToWorld[1.5,2.2,-.01]);_sack setDir(_dir+90);
_boxes setPos(_b modelToWorld[-1.6,1.05,.67]);_boxes setDir _dir;
_shelf setPos(_b modelToWorld[-1.7,.2,-.86]);_shelf setDir(_dir+270)}