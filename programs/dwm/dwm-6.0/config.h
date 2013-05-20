/*
Configuration file for DWM.
Maintainer: illusionist
https://www.github.com/nixmeal
*/
/*Appearance*/
#include "push.c"
#include "moveresize.c"
#include "bstack.c"
#define NUMCOLORS 6
static const char colors[NUMCOLORS][ColLast][20] = {
    // border     fg         bg
    { "#076342", "#eee8d5", "#002b36" },  // 01 - normal
    { "#2aa198", "#eee8d5", "#2aa198" },  // 02 - selected
    { "#B3354C", "#B3354C", "#002b36" },  // 03 - urgent
    { "#cb4b16", "#eee8d5", "#002b36" },  // 04 - orange (Occupied Color)
    { "#839496", "#839496", "#002b36" },  // 05 - Light Blue
    { "#859900", "#859900", "#002b36" },  // 06 - green
//    { "#877C43", "#877C43", "#020202" },  // 07 - yellow
//    { "#1C678C", "#1C678C", "#020202" },  // 08 - blue
//    { "#E300FF", "#E300FF", "#020202" },  // 09 - magenta
//    { "#000000", "#000000", "#000000" },  // unusable
//    { "#337373", "#337373", "#020202" },  // 0B - cyan
//    { "#808080", "#808080", "#020202" },  // 0C - light gray
//    { "#4C4C4C", "#4C4C4C", "#020202" },  // 0D - gray
//    { "#FFEE00", "#FFEE00", "#020202" },  // 0E - yellow2
//    { "#B1D354", "#B1D354", "#020202" },  // 0F - light green
//    { "#BF9F5F", "#BF9F5F", "#020202" },  // 10 - light yellow
//    { "#3995BF", "#3995BF", "#020202" },  // 11 - light blue
//    { "#A64286", "#A64286", "#020202" },  // 12 - light magenta
//    { "#6C98A6", "#6C98A6", "#020202" },  // 13 - light cyan
//    { "#FFA500", "#FFA500", "#020202" },  // 14 - orange
//    { "#0300ff", "#0300ff", "#802635" },  // 15 - warning
};

static const char font[]					= "Inconsolata 12";
static const unsigned int borderpx  		= 2;        	// border pixel of windows
static const unsigned int snap         		= 2;     	// snap pixel
static const unsigned int gappx				= 0;		// gap pixel between windows (uselessgaps patch)
static const Bool showbar               	= True;  	// False means no bar
static const Bool topbar                	= True;  	// False means bottom bar
static const unsigned int systrayspacing 	= 2;   		// systray spacing
static const Bool showsystray       		= True;     	// False means no systray
static const Bool transbar					= False;		// True means transparent status bar

/* Layout(s) */
static const float mfact      				= 0.63;  	// factor of master area size [0.05..0.95]
static const int nmaster      				= 1;     	// number of clients in master area
static const Bool resizehints 				= False; 	// True means respect size hints in tiled resizals
static const Layout layouts[] = {
	/* symbol	function */
	{ "[=]",	tile },
	{ "[m]",	monocle },    		/* first entry is default */
	{ "[ ]",	NULL },    		/* no layout function means floating behavior */
	{ "[b]",	bstack },
	{ "[g]",	gaplessgrid },
};

/* Tagging */
static const char *tags[] = { "1", "2", "3", "4", "BG"};

static const Rule rules[] = {
	/* class      		instance	title		tags mask	isfloating 	iscenterd	monitor */
	{ "Pidgin",   		NULL,       NULL,       (~0)-1,       False,    False, 		1 },
	{ "Thunderbird",    NULL,       NULL,       (1 << 0),     False,    False, 		1 },
	{ "Firefox",  		NULL,       NULL,       (1 << 1),     False,    False, 		1 },
	{ "vmware",   		NULL,       NULL,       (1 << 2),     False,    False, 		0 },
	{ "urxvt",    		NULL,       NULL,       (1 << 0),     False,    False, 		0 },
	{ "urxvtc",    		NULL,       NULL,       (1 << 0),     False,    False, 		0 },
};

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", colors[0][ColBG], "-nf", colors[0][ColFG], "-sb", colors[1][ColBG], "-sf", colors[1][ColFG], NULL };
static const char *webcmd[] = { "firefox", NULL };
static const char *killdwm[]		=	{ "killall", "dwm", NULL };
static const char *fileman[] 		= 	{ "pcmanfm", NULL };
static const char *terminal[]  		= 	{ "urxvtc", NULL };
//static const char *thunarterm[]		=	{ "/home/garry/.scripts/thunarterm", NULL };
//static const char *composite[]		=	{ "/home/garry/.scripts/composite", NULL };

/* key definitions */
#define Modkey Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ Modkey,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ Modkey|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ Modkey|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ Modkey|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

static Key keys[] = {
	/* modifier                     	key        				function        	argument */
	/* modifier                     key        function        argument */
	{ Modkey,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ Modkey|ShiftMask,             XK_Return, spawn,          {.v = terminal } },
	{ Modkey|ShiftMask,				XK_w,      spawn,          {.v = webcmd } },
	{ Modkey,						XK_e,      spawn,          {.v = fileman } },
	{ Modkey,                       XK_b,      togglebar,      {0} },
	{ Modkey,                       XK_j,      focusstack,     {.i = +1 } },
	{ Modkey,                       XK_k,      focusstack,     {.i = -1 } },
	{ Modkey|ShiftMask,             XK_j,      pushup,    	   {.i = +1 } },
	{ Modkey|ShiftMask,             XK_k,      pushdown,       {.i = -1 } },
	{ Modkey,                       XK_i,      incnmaster,     {.i = +1 } },
	{ Modkey,                       XK_d,      incnmaster,     {.i = -1 } },
	{ Modkey,                       XK_h,      setmfact,       {.f = -0.05} },
	{ Modkey,                       XK_l,      setmfact,       {.f = +0.05} },
	{ Modkey,                       XK_Return, zoom,           {0} },
	{ Modkey,                       XK_Tab,    view,           {0} },
	{ Modkey|ShiftMask,             XK_k,      killclient,     {0} },
	{ Modkey,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ Modkey,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ Modkey,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ Modkey,                       XK_s,      setlayout,      {.v = &layouts[3]} },
	{ Modkey,                       XK_g,      setlayout,      {.v = &layouts[4]} },
	{ Modkey,                       XK_space,  setlayout,      {0} },
	{ Modkey|ShiftMask,             XK_space,  togglefloating, {0} },
	{ Modkey,                       XK_0,      view,           {.ui = ~0 } },
	{ Modkey|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ Modkey,                       XK_comma,  focusmon,       {.i = -1 } },
	{ Modkey,                       XK_period, focusmon,       {.i = +1 } },
	{ Modkey|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ Modkey|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ Modkey|ShiftMask,             XK_q,      quit,           {0} },

};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	/* --------------------------------------menu-----------------------------------------*/
	{ ClkWinTitle,			0,				Button2,		killclient,		{0} },
	{ ClkWinTitle,          0,  		   	Button1,	    focusstack,     {.i = +1 } },
	{ ClkWinTitle,          0,  		    Button3,	    focusstack,     {.i = -1 } },
	/*====================================================================================*/
	{ ClkClientWin,         Modkey,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         Modkey,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         Modkey,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            Modkey,         Button1,        tag,            {0} },
	{ ClkTagBar,            Modkey,         Button3,        toggletag,      {0} },
};
/* vim: set ts=4 sw=4 tw=0: */
