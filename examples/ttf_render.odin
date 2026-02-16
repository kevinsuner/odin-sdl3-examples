package examples

import "core:c"
import "core:fmt"
import "core:strings"
import sdl "vendor:sdl3"
import "vendor:sdl3/ttf"

// FONT_PATH :: "assets/fonts/Inter-VariableFont_opsz,wght.ttf"
FONT_PATH :: "assets/fonts/SF-Pro.ttf"

window: ^sdl.Window
renderer: ^sdl.Renderer
font: ^ttf.Font
engine: ^ttf.TextEngine
ttf_text: ^ttf.Text
ttf_text2: ^ttf.Text
text_target: ^sdl.Texture

main :: proc() {
	_ = sdl.Init(sdl.INIT_VIDEO)
	_ = ttf.Init()

	window = sdl.CreateWindow("text", 0, 0, {.RESIZABLE, .HIGH_PIXEL_DENSITY})
	renderer = sdl.CreateRenderer(window, "")

	scale := sdl.GetWindowDisplayScale(window)
	engine = ttf.CreateRendererTextEngine(renderer)

	font = ttf.OpenFont(FONT_PATH, 13 * scale)

	text_target = sdl.CreateTexture(renderer, sdl.PixelFormat.RGBA8888, .TARGET, 0, 0)
	_ = sdl.SetTextureBlendMode(text_target, sdl.BLENDMODE_BLEND)


	text1 := ttf.CreateText(engine, font, "Testing", 0)
	ttf.SetTextColorFloat(text1, 0, 0, 0, sdl.ALPHA_OPAQUE_FLOAT)

	text2 := ttf.CreateText(engine, font, "Bold move", 0)
	ttf.SetTextColor(text2, 0, 0, 0, sdl.ALPHA_OPAQUE)


	fmt.println(f32(u8(sdl.ALPHA_OPAQUE)) / 255.0)
	fmt.println(text1.internal.color)
	fmt.println(text2.internal.color)

	is_running := true
	event: sdl.Event
	for is_running {
		resized := false
		for sdl.PollEvent(&event) {
			#partial switch event.type {
			case .QUIT:
				is_running = false
			case .WINDOW_RESIZED:
			}
		}


		sdl.SetRenderDrawColor(renderer, 255, 255, 255, 255)
		sdl.RenderClear(renderer)


		ttf.DrawRendererText(text1, 0, 0)
		ttf.DrawRendererText(text2, 0, 30)
		// _ = sdl.RenderTexture(renderer, text_target, nil, &sdl.FRect{0, 0, 0, 0})
		sdl.RenderPresent(renderer)
	}
}

app_init :: proc() {
}
