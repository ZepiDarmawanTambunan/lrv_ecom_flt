<div>
    @if($type === 'add')
      <a class="bg-danger hover:bg-blue-600 text-white font-bold py-2 px-4 rounded shadow" href="{{ $href }}">
        {{ $slot }}
      </a>
    @elseif($type === 'edit')
      <a class="bg-yellow-500 hover:bg-yellow-600 text-white font-bold py-2 px-4 rounded shadow" href="{{ $href }}">
        {{ $slot }}
      </a>
    @elseif($type === 'delete')
      <a class="bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded shadow" href="{{ $href }}">
        {{ $slot }}
      </a>
    @endif
  </div>
