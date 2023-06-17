@push('script')
<script>
    $(document).ready(function() {
        $('#btn-hapus').hide();
        $('.check-user-id').change(function(e) {
            if ($('.check-user-id:checked').length == $('.check-user-id').length) {
                $('#checked-all').prop('checked', true);
            }
            if ($(this).prop('checked')) {
                $('#btn-hapus').show();
            }
            if ($('.check-user-id:checked').length == 0) {
                $('#btn-hapus').hide();
            }
            if ($('.check-user-id:checked').length < $('.check-user-id').length) {
                $('#checked-all').prop('checked', false);
            }
        });
        $('#checked-all').click(function(e) {
            if ($(this).is(":checked")) {
                $('#btn-hapus').show();
                $('.check-user-id').prop('checked', true);
            } else {
                $('#btn-hapus').hide();
                $('.check-user-id').prop('checked', false);
            }
        });
        $('#btn-hapus').click(function(e) {
            let confirmHapus = confirm('Yakin hapus ?');
            if (confirmHapus) {
                $.ajax({
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    type: 'POST',
                    url: "{{ route('user.delete') }}",
                    data: $('.check-user-id').serialize(),
                    dataType: 'json',
                    beforeSend: function() {},
                    success: function(response) {
                        $('#alert-message').removeClass('d-none');
                        $('#alert-message').addClass('alert-success');
                        $('#alert-message').html(response.message);
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        $('#alert-message').removeClass('d-none');
                        $('#alert-message').addClass('alert-danger');
                        $('#alert-message').html(xhr.responseJSON.message);
                    },
                });
                e.preventDefault();
                return;
            }
        });
    })
</script>
@endpush

<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Users') }}
        </h2>
    </x-slot>

    <div class="alert d-none my-1" role="alert" id="alert-message"></div>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="p-4 bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <a href="{{route('user.create')}}" class="btn btn-primary mr-2">Tambah</a>
                <button type="button" id="btn-hapus" class="btn btn-danger">Hapus</button>

                <div class="table-responsive mt-3">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th width="1%;">
                                    <input type="checkbox" id="checked-all">
                                </th>
                                <th>Nama</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Akses</th>
                                <th class="text-center">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse ($model as $item)
                                <tr>
                                    <td>{!! Form::checkbox('user_id[]', $item->id, null, ['class' => 'check-user-id']) !!}</td>
                                    <td>{{ $item->name }}</td>
                                    <td>{{ $item->phone }}</td>
                                    <td>{{ $item->email }}</td>
                                    <td>{{ $item->roles }}</td>
                                    <td class="text-center">
                                        <a href="{{ route('user.edit', $item->id) }}"
                                            class="btn btn-sm btn-warning mx-2 mb-1 mb-md-0">
                                            <i class="bi bi-pencil-square d-md-inline d-none"></i>
                                            Edit
                                        </a>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="4">Tidak ada data</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                    <div class="mt-3">
                        {!! $model->links() !!}
                    </div>
                </div>

            </div>
        </div>
    </div>
</x-app-layout>

