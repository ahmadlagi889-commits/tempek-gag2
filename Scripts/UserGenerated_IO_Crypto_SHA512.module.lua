-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local u1 = table.create(80, 0);
local u2 = table.create(80, 0);
local u3 = {
    1116352408,
    1899447441,
    3049323471,
    3921009573,
    961987163,
    1508970993,
    2453635748,
    2870763221,
    3624381080,
    310598401,
    607225278,
    1426881987,
    1925078388,
    2162078206,
    2614888103,
    3248222580,
    3835390401,
    4022224774,
    264347078,
    604807628,
    770255983,
    1249150122,
    1555081692,
    1996064986,
    2554220882,
    2821834349,
    2952996808,
    3210313671,
    3336571891,
    3584528711,
    113926993,
    338241895,
    666307205,
    773529912,
    1294757372,
    1396182291,
    1695183700,
    1986661051,
    2177026350,
    2456956037,
    2730485921,
    2820302411,
    3259730800,
    3345764771,
    3516065817,
    3600352804,
    4094571909,
    275423344,
    430227734,
    506948616,
    659060556,
    883997877,
    958139571,
    1322822218,
    1537002063,
    1747873779,
    1955562222,
    2024104815,
    2227730452,
    2361852424,
    2428436474,
    2756734187,
    3204031479,
    3329325298,
    3391569614,
    3515267271,
    3940187606,
    4118630271,
    116418474,
    174292421,
    289380356,
    460393269,
    685471733,
    852142971,
    1017036298,
    1126000580,
    1288033470,
    1501505948,
    1607167915,
    1816402316
};
local u4 = {
    3609767458,
    602891725,
    3964484399,
    2173295548,
    4081628472,
    3053834265,
    2937671579,
    3664609560,
    2734883394,
    1164996542,
    1323610764,
    3590304994,
    4068182383,
    991336113,
    633803317,
    3479774868,
    2666613458,
    944711139,
    2341262773,
    2007800933,
    1495990901,
    1856431235,
    3175218132,
    2198950837,
    3999719339,
    766784016,
    2566594879,
    3203337956,
    1034457026,
    2466948901,
    3758326383,
    168717936,
    1188179964,
    1546045734,
    1522805485,
    2643833823,
    2343527390,
    1014477480,
    1206759142,
    344077627,
    1290863460,
    3158454273,
    3505952657,
    106217008,
    3606008344,
    1432725776,
    1467031594,
    851169720,
    3100823752,
    1363258195,
    3750685593,
    3785050280,
    3318307427,
    3812723403,
    2003034995,
    3602036899,
    1575990012,
    1125592928,
    2716904306,
    442776044,
    593698344,
    3733110249,
    2999351573,
    3815920427,
    3928383900,
    566280711,
    3454069534,
    4000239992,
    1914138554,
    2731055270,
    3203993006,
    320620315,
    587496836,
    1086792851,
    365543100,
    2618297676,
    3409855158,
    4234509866,
    987167468,
    1246189591
};
function lil_sig0(p5, p6)
    local v7 = bit32.rshift(p5, 1);
    local v8 = bit32.lshift(p6, 31);
    local v9 = bit32.rshift(p5, 8);
    local v10 = bit32.lshift(p6, 24);
    local v11 = bit32.rshift(p5, 7);
    local v12 = bit32.bxor(v7, v8, v9, v10, v11);
    local v13 = bit32.rshift(p6, 1);
    local v14 = bit32.lshift(p5, 31);
    local v15 = bit32.rshift(p6, 8);
    local v16 = bit32.lshift(p5, 24);
    local v17 = bit32.rshift(p6, 7);
    local v18 = bit32.lshift(p5, 25);
    return v12, bit32.bxor(v13, v14, v15, v16, v17, v18);
end;
function lil_sig1(p19, p20)
    local v21 = bit32.rshift(p19, 19);
    local v22 = bit32.lshift(p20, 13);
    local v23 = bit32.lshift(p19, 3);
    local v24 = bit32.rshift(p20, 29);
    local v25 = bit32.rshift(p19, 6);
    local v26 = bit32.bxor(v21, v22, v23, v24, v25);
    local v27 = bit32.rshift(p20, 19);
    local v28 = bit32.lshift(p19, 13);
    local v29 = bit32.lshift(p20, 3);
    local v30 = bit32.rshift(p19, 29);
    local v31 = bit32.rshift(p20, 6);
    local v32 = bit32.lshift(p19, 26);
    return v26, bit32.bxor(v27, v28, v29, v30, v31, v32);
end;
function big_sig0(p33, p34)
    local v35 = bit32.rshift(p33, 28);
    local v36 = bit32.lshift(p34, 4);
    local v37 = bit32.lshift(p33, 30);
    local v38 = bit32.rshift(p34, 2);
    local v39 = bit32.lshift(p33, 25);
    local v40 = bit32.rshift(p34, 7);
    local v41 = bit32.bxor(v35, v36, v37, v38, v39, v40);
    local v42 = bit32.rshift(p34, 28);
    local v43 = bit32.lshift(p33, 4);
    local v44 = bit32.lshift(p34, 30);
    local v45 = bit32.rshift(p33, 2);
    local v46 = bit32.lshift(p34, 25);
    local v47 = bit32.rshift(p33, 7);
    return v41, bit32.bxor(v42, v43, v44, v45, v46, v47);
end;
function big_sig1(p48, p49)
    local v50 = bit32.rshift(p48, 14);
    local v51 = bit32.lshift(p49, 18);
    local v52 = bit32.rshift(p48, 18);
    local v53 = bit32.lshift(p49, 14);
    local v54 = bit32.lshift(p48, 23);
    local v55 = bit32.rshift(p49, 9);
    local v56 = bit32.bxor(v50, v51, v52, v53, v54, v55);
    local v57 = bit32.rshift(p49, 14);
    local v58 = bit32.lshift(p48, 18);
    local v59 = bit32.rshift(p49, 18);
    local v60 = bit32.lshift(p48, 14);
    local v61 = bit32.lshift(p49, 23);
    local v62 = bit32.rshift(p48, 9);
    return v56, bit32.bxor(v57, v58, v59, v60, v61, v62);
end;
function processBlocks(p63, p64, p65, p66, p67)
    -- upvalues: u1 (copy), u2 (copy), u4 (copy), u3 (copy)
    local v68 = u1;
    local v69 = u2;
    local v70 = p63[1];
    local v71 = p63[2];
    local v72 = p63[3];
    local v73 = p63[4];
    local v74 = p63[5];
    local v75 = p63[6];
    local v76 = p63[7];
    local v77 = p63[8];
    local v78 = p64[1];
    local v79 = p64[2];
    local v80 = p64[3];
    local v81 = p64[4];
    local v82 = p64[5];
    local v83 = p64[6];
    local v84 = p64[7];
    local v85 = p64[8];
    for v102 = p66, p67, 128 do
        local _ = v102;
        for v87 = 1, 16 do
            local v88, v89, v90, v91, v92, v93, v94, v95 = string.byte(p65, v102, v102 + 7);
            local v96 = bit32.lshift(v88, 24);
            local v97 = bit32.lshift(v89, 16);
            local v98 = bit32.lshift(v90, 8);
            v68[v87] = bit32.bor(v96, v97, v98, v91);
            local v99 = bit32.lshift(v92, 24);
            local v100 = bit32.lshift(v93, 16);
            local v101 = bit32.lshift(v94, 8);
            v69[v87] = bit32.bor(v99, v100, v101, v95);
            local v102 = v102 + 8;
        end;
        for v103 = 17, 80 do
            local v104, v105 = lil_sig0(v68[v103 - 15], v69[v103 - 15]);
            local v106, v107 = lil_sig1(v68[v103 - 2], v69[v103 - 2]);
            local v108 = v69[v103 - 16] + v105 + v69[v103 - 7] + v107;
            v69[v103] = bit32.bor(v108, 0);
            v68[v103] = v68[v103 - 16] + v104 + v68[v103 - 7] + v106 + v108 // 4294967296;
        end;
        local v109 = v71;
        local v110 = v81;
        local v111 = v76;
        local v112 = v82;
        local v113 = v83;
        local v114 = v70;
        local v115 = v80;
        local v116 = v77;
        local v117 = v73;
        local v118 = v78;
        local v119 = v84;
        local v120 = v74;
        local v121 = v85;
        local v122 = v75;
        local v123 = v79;
        local v124 = v72;
        for v125 = 1, 80 do
            local v126, v127 = big_sig0(v70, v78);
            local v128, v129 = big_sig1(v74, v82);
            local v130 = v85 + v129;
            local v131 = bit32.band(v82, v83);
            local v132 = bit32.band(-1 - v82, v84);
            local v133 = v130 + bit32.bor(v131, v132, 0) + u4[v125] + v69[v125];
            local v134 = v77 + v128;
            local v135 = bit32.band(v74, v75);
            local v136 = bit32.band(-1 - v74, v76);
            local v137 = v134 + bit32.bor(v135, v136, 0) + u3[v125] + v68[v125] + v133 // 4294967296;
            local v138 = bit32.bor(v133, 0);
            local v139 = v127 + bit32.band(v80, v79);
            local v140 = bit32.bxor(v80, v79);
            local v141 = v139 + bit32.band(v78, v140);
            local v142 = v126 + bit32.band(v72, v71);
            local v143 = bit32.bxor(v72, v71);
            local v144 = v142 + bit32.band(v70, v143);
            local v145 = v138 + v81;
            local v146 = v137 + v73 + v145 // 4294967296;
            local v147 = bit32.bor(v145, 0);
            local v148 = v138 + v141;
            local v149 = v137 + v144 + v148 // 4294967296;
            local v150 = bit32.bor(v148, 0);
            v85 = v84;
            v84 = v83;
            v83 = v82;
            v82 = v147;
            v77 = v76;
            v76 = v75;
            v75 = v74;
            v74 = v146;
            v73 = v72;
            v72 = v71;
            v71 = v70;
            v70 = v149;
            v81 = v80;
            v80 = v79;
            v79 = v78;
            v78 = v150;
        end;
        local v151 = v118 + v78;
        v70 = bit32.bor(v114 + v70 + v151 // 4294967296, 0);
        v78 = bit32.bor(v151, 0);
        local v152 = v123 + v79;
        v71 = bit32.bor(v109 + v71 + v152 // 4294967296, 0);
        v79 = bit32.bor(v152, 0);
        local v153 = v115 + v80;
        v72 = bit32.bor(v124 + v72 + v153 // 4294967296, 0);
        v80 = bit32.bor(v153, 0);
        local v154 = v110 + v81;
        v73 = bit32.bor(v117 + v73 + v154 // 4294967296, 0);
        v81 = bit32.bor(v154, 0);
        local v155 = v112 + v82;
        v74 = bit32.bor(v120 + v74 + v155 // 4294967296, 0);
        v82 = bit32.bor(v155, 0);
        local v156 = v113 + v83;
        v75 = bit32.bor(v122 + v75 + v156 // 4294967296, 0);
        v83 = bit32.bor(v156, 0);
        local v157 = v119 + v84;
        v76 = bit32.bor(v111 + v76 + v157 // 4294967296, 0);
        v84 = bit32.bor(v157, 0);
        local v158 = v121 + v85;
        v77 = bit32.bor(v116 + v77 + v158 // 4294967296, 0);
        v85 = bit32.bor(v158, 0);
    end;
    p63[1] = v70;
    p64[1] = v78;
    p63[2] = v71;
    p64[2] = v79;
    p63[3] = v72;
    p64[3] = v80;
    p63[4] = v73;
    p64[4] = v81;
    p63[5] = v74;
    p64[5] = v82;
    p63[6] = v75;
    p64[6] = v83;
    p63[7] = v76;
    p64[7] = v84;
    p63[8] = v77;
    p64[8] = v85;
end;
function sha512(p159)
    local v160 = {
        1779033703,
        3144134277,
        1013904242,
        2773480762,
        1359893119,
        2600822924,
        528734635,
        1541459225
    };
    local v161 = {
        4089235720,
        2227873595,
        4271175723,
        1595750129,
        2917565137,
        725511199,
        4215389547,
        327033209
    };
    local v162 = #p159;
    if v162 > 1125899906842624 then
        error("cannot calculate the SHA-512 hash of a string longer than 2^50 bytes", 2);
    end;
    local v163 = v162 % 128;
    if v162 >= 128 then
        processBlocks(v160, v161, p159, 1, v162 - v163);
    end;
    local v164 = bit32.band(v163 + 64, 4294963200);
    local v165 = {
        v163 == 0 and "" or string.sub(p159, -v163),
        "\128",
        string.rep("\0", (v164 - v163 - 17) % 128),
        string.pack(">L", v162 * 8 / 4294967296),
        string.pack(">L", v162 * 8 % 4294967296)
    };
    local v166 = table.concat(v165);
    processBlocks(v160, v161, v166, 1, #v166);
    local v167 = buffer.create(64);
    for v168 = 1, 8 do
        local v169 = (v168 - 1) * 8;
        local v170 = bit32.byteswap(v160[v168]);
        buffer.writeu32(v167, v169, v170);
        local v171 = (v168 - 1) * 8 + 4;
        local v172 = bit32.byteswap(v161[v168]);
        buffer.writeu32(v167, v171, v172);
    end;
    return v167;
end;
local v175 = {
    Name = "SHA-512",
    BlockSize = 128,
    OutputSize = 64,
    Digest = function(p173) --[[ Name: Digest, Line 347 ]]
        return buffer.tostring(sha512(p173));
    end,
    DigestBuffer = function(p174) --[[ Name: DigestBuffer, Line 350 ]]
        return sha512(buffer.tostring(p174));
    end,
    DigestToBuffer = sha512
};
table.freeze(v175);
return v175;