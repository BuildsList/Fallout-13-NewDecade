/*ALL DEFINES RELATED TO CONSTRUCTION, CONSTRUCTING THINGS, OR CONSTRUCTED OBJECTS GO HERE*/

//Defines for construction states

//girder construction states
#define GIRDER_NORMAL 0
#define GIRDER_REINF_STRUTS 1
#define GIRDER_REINF 2
#define GIRDER_DISPLACED 3
#define GIRDER_DISASSEMBLED 4

//rwall construction states
#define INTACT 0
#define SUPPORT_LINES 1
#define COVER 2
#define CUT_COVER 3
#define BOLTS 4
#define SUPPORT_RODS 5
#define SHEATH 6

//default_unfasten_wrench() return defines
#define CANT_UNFASTEN 0
#define FAILED_UNFASTEN 1
#define SUCCESSFUL_UNFASTEN 2

//disposal unit mode defines, which do double time as the construction defines
#define PRESSURE_OFF 0
#define PRESSURE_ON 1
#define PRESSURE_MAXED 2
#define SCREWS_OUT -1

//ai core defines
#define EMPTY_CORE 0
#define CIRCUIT_CORE 1
#define SCREWED_CORE 2
#define CABLED_CORE 3
#define GLASS_CORE 4
#define AI_READY_CORE 5

//field generator construction defines
#define FG_UNSECURED 0
#define FG_SECURED 1
#define FG_WELDED 2

//emitter construction defines
#define EM_UNSECURED 0
#define EM_SECURED 1
#define EM_WELDED 2

//Construction defines for the pinion airlock
#define GEAR_SECURE 1
#define GEAR_UNFASTENED 2
#define GEAR_LOOSE 3

//other construction-related things

//windows affected by nar-sie turn this color.
#define NARSIE_WINDOW_COLOUR "#7D1919"

//let's just pretend fulltile windows being children of border windows is fine
#define FULLTILE_WINDOW_DIR NORTHEAST

//Material defines, for determining how much of a given material an item contains
#define MAT_METAL		"$metal"
#define MAT_GLASS		"$glass"
#define MAT_SILVER		"$silver"
#define MAT_GOLD		"$gold"
#define MAT_DIAMOND		"$diamond"
#define MAT_URANIUM		"$uranium"
#define MAT_PLASMA		"$plasma"
#define MAT_BANANIUM	"$bananium"
#define MAT_TITANIUM	"$titanium"
#define MAT_COOPER		"$cooper"
#define MAT_BIOMASS		"$biomass"
//The amount of materials you get from a sheet of mineral like iron/diamond/glass etc
#define MINERAL_MATERIAL_AMOUNT 2000
//The maximum size of a stack object.
#define MAX_STACK_SIZE 50
//maximum amount of cable in a coil
#define MAXCOIL 30

//tablecrafting defines
#define CAT_NONE	""
#define CAT_WEAPON	"????????????"
#define CAT_BLUEPRINT	"??????????????"
#define CAT_AMMO	"??????????????????"
#define CAT_MEDICINE	"????????????????"
#define CAT_ARMOR "??????????"
#define CAT_CLOTHING "????????????"
#define CAT_MISC	"??????????"
#define CAT_PRIMAL  "??????????????????"
#define CAT_BREAD	"????????"
#define CAT_BURGER	"??????????????"
#define CAT_CAKE	"??????????"
#define CAT_EGG	"Egg-Based Food"
#define CAT_MEAT	"????????"
#define CAT_MISCFOOD	"Misc. Food"
#define CAT_PASTRY	"Pastries"
#define CAT_PIE	"????????????"
#define CAT_PIZZA	"??????????"
#define CAT_SALAD	"????????????"
#define CAT_SANDWICH	"????????????????"
#define CAT_SOUP	"????????"
#define CAT_SPAGHETTI	"????????????????"
#define CAT_EXPLOSIVES	"????????????????????"
