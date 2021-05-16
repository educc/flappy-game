package states.play.event;

import haxe.ds.EnumValueMap;
import haxe.ds.List;

class EventSource
{
	var mapFn:EnumValueMap<PlayEvent, List<Void->Void>>;

	public function new()
	{
		mapFn = new EnumValueMap();
	}

	public function subscribe(e:PlayEvent, fn:Void->Void)
	{
		var list = mapFn.get(e);

		if (list == null)
		{
			list = new List();
			list.add(fn);
		}
		else
		{
			list.add(fn);
		}
		mapFn.set(e, list);
	}

	public function emit(e:PlayEvent)
	{
		var list = mapFn.get(e);
		if (list == null)
		{
			return;
		}

		for (fn in list)
		{
			fn();
		}
	}
}
