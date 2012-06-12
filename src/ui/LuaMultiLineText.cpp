#include "MultiLineText.h"
#include "LuaObject.h"

namespace UI {

class LuaMultiLineText {
public:

};

}

static bool promotion_test(DeleteEmitter *o)
{
	return dynamic_cast<UI::MultiLineText*>(o);
}

using namespace UI;

template <> const char *LuaObject<UI::MultiLineText>::s_type = "UI.MultiLineText";

template <> void LuaObject<UI::MultiLineText>::RegisterClass()
{
	static const char *l_parent = "UI.Widget";

	static const luaL_Reg l_methods[] = {

        { 0, 0 }
	};

	LuaObjectBase::CreateClass(s_type, l_parent, l_methods, 0, 0);
	LuaObjectBase::RegisterPromotion(l_parent, s_type, promotion_test);
}
