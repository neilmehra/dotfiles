//!HOOK MAIN
//!BIND HOOKED
//!DESC Lust Lens (MV/PMV enhancer: highlight bloom + edge-safe clarity + warm skin pop)

// ===== Tunables (edit & press "i" in mpv) =====

// Soft cinematic (Ariana MVs, skin glow):
// BLOOM_STRENGTH=0.24, BLOOM_RADIUS=2.6, BLOOM_THRESH=0.62, CLARITY_AMOUNT=0.10, SAT_GLOBAL=1.08, WARM_SAT_EXTRA=0.05, VIGNETTE_AMT=0.12
//
// Crisp erotic (PMV/HMV, glossy pop):
// BLOOM_STRENGTH=0.18, BLOOM_RADIUS=2.0, BLOOM_THRESH=0.68, CLARITY_AMOUNT=0.14, SAT_GLOBAL=1.12, WARM_SAT_EXTRA=0.08, VIGNETTE_AMT=0.10
//
// Max sensual (indica body-high):
// BLOOM_STRENGTH=0.28, BLOOM_RADIUS=2.8, BLOOM_THRESH=0.60, CLARITY_AMOUNT=0.12, SAT_GLOBAL=1.12, WARM_SAT_EXTRA=0.09, VIGNETTE_AMT=0.16, GRAIN_AMT=0.007

const float SAT_GLOBAL      = 1.3; // strong global saturation
const float WARM_SAT_EXTRA  = 0.01; // really juice reds/pinks
const float WARM_HL_GAIN    = 0.022; // warm highlights (skin sheen)
const float BLOOM_STRENGTH  = 0.28; // heavy glow
const float BLOOM_RADIUS    = 2.4;  // blur radius for glow
const float BLOOM_THRESH    = 0.58; // glow kicks in early (skin catches it)
const float CLARITY_AMOUNT  = 0.16; // strong edge contrast
const float CLARITY_RADIUS  = 1.2;
const float VIGNETTE_AMT    = 0.18; // pull focus to center
const float VIGNETTE_SOFT   = 0.90;
const float GRAIN_AMT       = 0.006; // keep a little texture

// ===== Helpers =====
float luma(vec3 c){ return dot(c, vec3(0.299, 0.587, 0.114)); }

float hash(vec2 p){
    p = fract(p*vec2(123.34,456.21));
    p += dot(p,p+45.32);
    return fract(p.x*p.y);
}

vec3 sampleTex(vec2 uv){ return HOOKED_tex(clamp(uv, 0.0, 1.0)).rgb; }

// 9-tap box blur
vec3 blur9(vec2 uv, vec2 r){
    vec3 s =
          sampleTex(uv)
        + sampleTex(uv + vec2( r.x,  0.0))
        + sampleTex(uv + vec2(-r.x,  0.0))
        + sampleTex(uv + vec2( 0.0,  r.y))
        + sampleTex(uv + vec2( 0.0, -r.y))
        + sampleTex(uv + vec2( r.x,  r.y))
        + sampleTex(uv + vec2(-r.x,  r.y))
        + sampleTex(uv + vec2( r.x, -r.y))
        + sampleTex(uv + vec2(-r.x, -r.y));
    return s * (1.0/9.0);
}

vec4 hook(){
    vec2 uv    = HOOKED_pos;
    vec2 texel = HOOKED_pt;        // 1 / size
    vec2 res   = 1.0 / texel;

    vec3 col   = sampleTex(uv);
    float Y0   = luma(col);

    // === Edge-safe clarity (local contrast via unsharp, restrained at hard edges) ===
    vec3 blurC   = blur9(uv, texel * CLARITY_RADIUS);
    vec3 high    = col - blurC;
    float edgish = smoothstep(0.08, 0.25, length(high)); // strong edges -> less boost
    col += high * (CLARITY_AMOUNT * (1.0 - 0.35*edgish));

    // === Highlight-only bloom with warm bias ===
    float mask = smoothstep(BLOOM_THRESH - 0.10, BLOOM_THRESH + 0.10, Y0);
    vec3 blurB = blur9(uv, texel * BLOOM_RADIUS);
    col = mix(col, blurB, BLOOM_STRENGTH * mask);
    col.rg += vec2(WARM_HL_GAIN, WARM_HL_GAIN*0.5) * mask; // warm the glow subtly

    // === Selective saturation (favor warm hues) ===
    float Y  = luma(col);
    float cx = max(max(col.r, col.g), col.b) - min(min(col.r, col.g), col.b); // crude sat measure
    float warm_w = smoothstep(0.0, 0.6, col.r - (0.8*col.g + 0.6*col.b));     // weight for reds/pinks
    float sat_mul = SAT_GLOBAL + WARM_SAT_EXTRA * warm_w * smoothstep(0.1, 0.8, Y); // more in mids/highs
    col = vec3(Y) + (col - vec3(Y)) * sat_mul;

    // === Gentle vignette ===
    float d = distance(uv, vec2(0.5));
    float vig = smoothstep(1.0, VIGNETTE_SOFT, d + VIGNETTE_AMT);
    col *= mix(1.0, 0.92, vig);

    // === Micro-grain (time-varying, more in shadows/mids) ===
    float g = (hash(uv*res + float(frame)*0.27) * 2.0 - 1.0);
    float maskG = smoothstep(0.0, 0.8, 1.0 - Y);
    col += g * GRAIN_AMT * maskG;

    return vec4(clamp(col, 0.0, 1.0), 1.0);
}
