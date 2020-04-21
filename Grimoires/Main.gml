#define Main
globalvar sprLecturn, sprDruidGrimoire, sprWizardGrimoire, sprMinerGrimoire, sprBuildGrimoire, sprSlimeGrimoire, sprSkullGrimoire, sprBeetGrimoire, sprToxicGrimoire;
globalvar usedSigilSlime, usedSigilSkull, usedSigilBeet, usedSigilToxic;

//Dimensions are 22 x 35 (Plan to change the lecturn art eventually as it isn't as good as I like right now)
sprLecturn = sprite_add("Assets/Lecturn.png", 1, false, false, 11, 32);

//Add Lecturn unlocking to Thaumaturgy desc. and sigil grimoires to Summoning desc.
LocalizationAddKey("english", "skillDesc51", "U unlocks expert level**scrolls and potions**U unlocks lecturns");
LocalizationAddKey("english", "skillDesc62", "U unlocks sigil maker**U unlocks boss grimoires**U shrines recharge twice as fast")

//The only collidable part should be the base
sprite_collision_mask(sprLecturn, false, 2, 0, 27, 22, 35, 1, 0);

//All Grimoires are 12 x 16
sprDruidGrimoire = sprite_add("Assets/Druid Grimoire.png", 1, false, false, 6, 8);
sprWizardGrimoire = sprite_add("Assets/Wizard Grimoire.png", 1, false, false, 6, 8);
sprMinerGrimoire = sprite_add("Assets/Miner Grimoire.png", 1, false, false, 6, 8);
sprBuildGrimoire = sprite_add("Assets/Builder Grimoire.png", 1, false, false, 6, 8);
sprSlimeGrimoire = sprite_add("Assets/Slime Grimoire.png", 1, false, false, 6, 8);
sprSkullGrimoire = sprite_add("Assets/Skull Grimoire.png", 1, false, false, 6, 8);
sprBeetGrimoire = sprite_add("Assets/Beet Grimoire.png", 1, false, false, 6, 8);
sprToxicGrimoire = sprite_add("Assets/Toxic Grimoire.png", 1, false, false, 6, 8);

    #region Grimoires

global.DruidGrimoire = ItemCreate(
    undefined,
    "Druid Grimoire",
    "Like the scroll, but infinite!",
    sprDruidGrimoire,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [Item.RoyalClothing, 5, Item.DruidScroll, 25, Item.StarFragment, 10],
    ScriptWrap(OnUse_DruidGrimoire),
    60 * 15,
    true
);

global.WizardGrimoire = ItemCreate(
    undefined,
    "Wizard Grimoire",
    "Like the scroll, but infinite!",
    sprWizardGrimoire,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [Item.RoyalClothing, 5, Item.WizardScroll, 25, Item.StarFragment, 10],
    ScriptWrap(OnUse_WizardGrimoire),
    60 * 15,
    true
);

global.MinerGrimoire = ItemCreate(
    undefined,
    "Miner Grimoire",
    "Like the scroll, but infinite!",
    sprMinerGrimoire,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [Item.RoyalClothing, 5, Item.MinerScroll, 25, Item.StarFragment, 10],
    ScriptWrap(OnUse_MinerGrimoire),
    60 * 15,
    true
);

global.BuildGrimoire = ItemCreate(
    undefined,
    "Build Grimoire",
    "Like the scroll, but infinite!",
    sprBuildGrimoire,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [Item.RoyalClothing, 5, Item.BuilderScroll, 25, Item.StarFragment, 10],
    ScriptWrap(OnUse_BuildGrimoire),
    60 * 15,
    true
);

global.SlimeGrimoire = ItemCreate(
    undefined,
    "Slime Grimoire",
    "Summon the Slime King as much as you want!",
    sprSlimeGrimoire,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [Item.RoyalClothing, 5, Item.SigilSlime, 25, Item.StarFragment, 10],
    ScriptWrap(OnUse_SlimeGrimoire),
    60 * 15,
    true 
);

global.SkullGrimoire = ItemCreate(
    undefined,
    "Skull Grimoire",
    "Summon the Skeleton King as much as you want!",
    sprSkullGrimoire,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [Item.RoyalClothing, 5, Item.SigilSkull, 25, Item.StarFragment, 10],
    ScriptWrap(OnUse_SkullGrimoire),
    60 * 15,
    true 
);

global.BeetGrimoire = ItemCreate(
    undefined,
    "Beet Grimoire",
    "Summon the Dark Beet as much as you want!",
    sprBeetGrimoire,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [Item.RoyalClothing, 5, Item.SigilBeet, 25, Item.StarFragment, 10],
    ScriptWrap(OnUse_BeetGrimoire),
    60 * 15,
    true 
);

global.ToxicGrimoire = ItemCreate(
    undefined,
    "Toxic Grimoire",
    "Summon the Toxic Guardian as much as you want!",
    sprToxicGrimoire,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [Item.RoyalClothing, 5, Item.SigilToxic, 25, Item.StarFragment, 10],
    ScriptWrap(OnUse_ToxicGrimoire),
    60 * 15,
    true 
);

    #endregion

    #region Lecturn

global.Lecturn = StructureCreate(
    undefined,
    "Lecturn",
    "Craft grimoires with magical properties!",
    StructureType.Base,
    sprLecturn,
    undefined,
    [Item.RoyalClothing, 5, Item.StarFragment, 15, Item.Wood, 20],
    2,
    true,
    [global.DruidGrimoire, global.WizardGrimoire, global.MinerGrimoire, global.BuildGrimoire], //Add sigil Grimoires with Summoning
    false, //edit to true when they get Thaumaturgy
    BuildMenuCategory.Magical,
    undefined,
)

#define OnSystemStep()
//check if they have drilling and haven't already unlocked the structure
if (HasSkill(Skill.Thaumaturgy) && !StructureGet(global.Lecturn, StructureData.Unlocked)) {
    StructureEdit(global.Lecturn, StructureData.Unlocked, true);
} else if (HasSkill(Skill.Summoning) && array_length_1d(StructureGet(global.Lecturn, StructureData.Items)) == 4) {
    StructureAddItem(global.Lecturn, global.SlimeGrimoire);
    StructureAddItem(global.Lecturn, global.SkullGrimoire);
    StructureAddItem(global.Lecturn, global.BeetGrimoire);
    StructureAddItem(global.Lecturn, global.ToxicGrimoire);
}

    #endregion