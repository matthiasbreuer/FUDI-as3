/**
 *  Copyright (c) 2010, Matthias Breuer <www.matthiasbreuer.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
 
package {
	import com.bit101.components.Knob;
	import com.bit101.components.Label;
	import com.matthiasbreuer.controls.Loader;
	import com.matthiasbreuer.net.fudi.Netsend;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Matthias Breuer -- www.mattbreuer.com
	 */
	public class NetsendExample extends Sprite {
		private var loader : Loader;
		private var netsend : Netsend;
		private var volume : Knob;		private var freq : Knob;

		public function NetsendExample() {
			netsend = new Netsend();
			netsend.addEventListener(Event.CONNECT, onConnect, false, 0, true);			netsend.connect("localhost", 3000);
			loader = new Loader("loader", null, netsend, Event.CONNECT, stage);
			loader.x = stage.stageWidth / 2;
			loader.y = stage.stageHeight / 2;
		}

		private function createInterface() : void {
			volume = new Knob(stage, 10, 0, "Volume", onChange);
			freq = new Knob(stage, 80, 0, "Frequency", onChange);
			freq.maximum = 400;
			var description : Label = new Label(stage, 10, 75, "This will send the values\nof the volume and\nfrequency sliders to a\npuredata netreceive at\nlocalhost on port 3000.");
		}

		private function onChange($e : Event) : void {
			netsend.send(volume.value / 100, freq.value);
		}

		private function onConnect($e : Event) : void {
			createInterface();
		}
	}
}
