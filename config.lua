Config = {}

Config.OpenMenu = 303 -- Key: U
Config.AntiSpamCooldown = 0
Config.Language = {
    Title = "Inventar",
    PleaseWait = "Vent venligst...",
    Error = "Der opstod et problem.",
    WarningTitle = "Advarsel",
    WeaponNotEquipped = "Du har ikke taget våbnet i brug endnu.",
    CannotBeUsed = "Denne genstand kan ikke benyttes fra dit inventar",
    NotEnoughtSpace = "Personen har ikke plads i sin taske",
    NoNearby = "Ingen personer i nærheden"
}

items = {}
-- DROGAS
items["pmaconha"] = {"drugs", 15, "23.png", "P. de maconha", 0.10, "Coma pão filha da puta"}
items["maconha"] = {"drugs", 15, "maconha.png", "Maconha", 0.10, "Coma pão filha da puta"}
items["cocaina"] = {"drugs", 15, "7.png", "P. de coca", 0.07, "Coma pão filha da puta"}
items["pilula"] = {"food", 0, "pilula.png", "Remédio", 0.02, "Coma pão filha da puta"}
-- ARMAS/COMBUSTIVEL
items["wbody|WEAPON_COMBATPISTOL"] = {"weapon", 0, "combatpistol.png", "Pistola 9mm", 0.20, "Coma pão filha da puta"}
items["wbody|WEAPON_PISTOL_MK2"] = {"weapon", 0, "combatpistol.png", "Pistola FiveSeven", 0.20, "Coma pão filha da puta"}
items["wammo|WEAPON_COMBATPISTOL"] = {"ammo", 0, "m_pistola_9mm.png", "M. Pistola", 0.10,"Coma pão filha da puta"}
items["wammo|WEAPON_PETROLCAN"] = {"ammo", 0, "12.png", "Litros Gasolina", 0.07, "Coma pão filha da puta"}
items["wbody|WEAPON_PETROLCAN"] = {"weapon", 0, "12.png", "Galão", 0.07, "Coma pão filha da puta"}
-- COMIDA/BEBIDA
items["pao"] = {"food", -22, "bread.png", "Pão", 0.07, "Coma pão filha da puta"}
items["batatafrita"] = {"food", -22, "batatafrita.png", "Batata-Frita", 0.05, "Batatafrita"}
items["hamburger"] = {"food", -22, "burger.png", "Hamburger", 0.05, "Hamburger"}
items["hotdog"] = {"food", -22, "hotdog.png", "Hot-Dog", 0.05, "Hot-Dog"}
items["nuggets"] = {"food", -22, "nuggets.png", "Nuggets", 0.05, "Nuggets"}
items["maca"] = {"food", -22, "apple.png", "Maçã", 0.05, "Maçã"}
items["donut"] = {"food", -22, "donuts.png", "Donut", 0.05, "Donut"}
items["refrigerante"] = {"drink", -22, "refrigerante.png", "Refrigerante", 0.05, "Refriiiii"}
items["whisky"] = {"drink", -22, "whisky.png", "Whisky", 0.05, "Whisky beber"}
items["cerveja"] = {"drink", -22, "cerveja.png", "Cerveja", 0.05, "Cerveja"}
items["energetico"] = {"drink", -22, "energetico.png", "Energético", 0.05, "Energetico"}
items["cafe"] = {"drink", -22, "coffe.png", "Café", 0.05, "Cafézin pra relaxar"}
items["vinho"] = {"drink", -22, "vinho.png", "Vinho", 0.05, "Vinho so o sangue de buceta"}
items["suco"] = {"drink", -22, "sujo.png", "Suco", 0.05, "aiiiiii que delicia cara"}
-- ITENS ROUBO
items["anel"] = {"item", 0, "anel.png", "Anel roubado", 0.10, "Coma pão filha da puta"}
items["cellroubado"] = {"item", 0, "cellroubado.png", "Celular roubado", 0.10, "Coma pão filha da puta"}
items["perfumeroubado"] = {"item", 0, "perfume.png", "Perfume roubado", 0.10, "Coma pão filha da puta"}
-- ITENS EMPREGO
items["trigo"] = {"item", 0, "48.png", "Trigo", 0.07, "Trigo trigo trigo"}
items["garrafavazia"] = {"item", 0, "garrafavazia.png", "Garrafa Vazia", 0.07, "Garrafa vazia para ordenha de leite"}
items["garrafadeleite"] = {"item", 0, "garrafadeleite.png", "Garrafa de Leite", 0.07, "Garrafa de leite pós ordenha."}
items["queijo"] = {"item", 0, "queijo.png", "Queijo", 0.07, "Queijo processado e pronto para consumo/venda."}
items["pudim"] = {"item", 0, "pudim.png", "Pudim", 0.07, "Pudim processado e pronto para consumo/venda."}
items["leite"] = {"item", 0, "leite.png", "Leite", 0.07, "Leite pronto para consumo/venda."}
items["galinha"] = {"item", 0, "galinha.png", "Galinha", 0.07, "Leite pronto para consumo/venda."}
items["galinhadepenada"] = {"item", 0, "galinhadepenada.png", "Galinha Depenada", 0.07, "Leite pronto para consumo/venda."}
items["filedegalinha"] = {"item", 0, "filedegalinha.png", "Filé de Galinha", 0.07, "Filé de galinha pronto para o consumo/venda."}
items["tora"] = {"item", 0, "filedegalinha.png", "Tora de Madeira", 0.07, "Tora tora tora tora"}