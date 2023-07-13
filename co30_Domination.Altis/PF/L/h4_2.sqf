//Land_House_2B01_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_book=createSimpleObject["a3\Structures_F_Enoch\Furniture\Cases\library_a\library_a.p3d",[0,0,0]];
{_f pushBack _x}forEach[_book];
_b setVariable["PF",_f];

_book setPos(_b modelToWorld[-1,-2.32,-4.2]);_book setDir(_dir+180);

{_x setDir _dir}forEach[_chair,_junk,_junk2,_junk4,_junk5,_rack,_rack2];
{_x setDir(_dir+180)}forEach[_book,_desk,_desk2]}