Config = {}

Config['GetObject'] = ""

Config['ปุ่ม'] = 'E'

Config['จุดรับของ'] = {
    ['ตำแหน่ง'] = vector3(0,0,0),
    ['Marker'] = {
        Id = 1,                     --https://docs.fivem.net/docs/game-references/markers/
        Size = 1.0,
        Color = {255,255,255,100}
    },
    ['Blip'] = {
        Id = 1,
        Size = 1.0,
        Color = 50,                 --https://docs.fivem.net/docs/game-references/blips/
        Name = "Daily Reward"
    }
}

Config['เวลาออนไลน์'] = 10           --หน่วยเป็นนาที

Config['ไอเทม'] = {
    {name = "water", count = {1,2}},
    {name = "fish", count = {1,2}}
}

Config['Log'] = "https://discord.com/api/webhooks/1083591169264590969/z6mTGBuJjj7gauR1BjAZB-qGWkUYKDlkYwPvYeZmsy2v8_sqW2N1kpJvZIt2dNYx8mqB"