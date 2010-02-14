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
	import com.bit101.components.ProgressBar;
	import com.matthiasbreuer.controls.Loader;
	import com.matthiasbreuer.net.fudi.Netreceive;
	import com.matthiasbreuer.utils.eTrace;

	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;

	/**
	 * @author Matthias Breuer -- www.mattbreuer.com
	 */
	public class NetreceiveExample extends Sprite {
		private var loader : Loader;
		private var netreceive : Netreceive;
		private var env : ProgressBar;		private var vol : Knob;

		public function NetreceiveExample() {
			netreceive = new Netreceive(3001);
			netreceive.addEventListener(Event.CONNECT, onConnect, false, 0, true);			netreceive.addEventListener(DataEvent.DATA, onData, false, 0, true);
			loader = new Loader("loader", null, netreceive, Event.CONNECT, stage);
			loader.x = stage.stageWidth / 2;
			loader.y = stage.stageHeight / 2;
		}

		private function createInterface() : void {
			vol = new Knob(stage, 45, 0, "Volume");
			env = new ProgressBar(stage, 10, 80);
			env.maximum = 100;
			var envLabel : Label = new Label(stage, 10, env.y + env.height, "Envelope");
			var description : Label = new Label(stage, 10, 110, "This receives messages\nfrom netsend objects\nconnected to localhost\non port 3001.");
		}

		private function onConnect($e : Event) : void {
			createInterface();
		}

		private function onData($e : DataEvent) : void {
			eTrace($e.data);
			var values : Array = netreceive.convertData($e.data, "ff");
			env.value = values[0];
			vol.value = values[1] * 100;
		}
	}
}
