<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Users') }}
        </h2>
    </x-slot>

    <div class="row justify-content-center my-4">
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    {!! Form::model($model, ['route' => $route, 'method' => $method]) !!}
                    <div class="form-group mt-3">
                        <label for="name" class="form-label">Nama</label>
                        {!! Form::text('name', null, ['class' => 'form-control', 'required']) !!}
                        <small class="text-danger">{{ $errors->first('name') }}</small>
                    </div>
                    <div class="form-group mt-3">
                        <label for="username" class="form-label">Username</label>
                        {!! Form::text('username', null, ['class' => 'form-control', 'required']) !!}
                        <small class="text-danger">{{ $errors->first('username') }}</small>
                    </div>
                    <div class="form-group mt-3">
                        <label for="email" class="form-label">Email</label>
                        {!! Form::email('email', null, [
                            'class' => 'form-control',
                            'required' => 'required',
                            'placeholder' => 'eg: foo@bar.com',
                        ]) !!}
                        <small class="text-danger">{{ $errors->first('email') }}</small>
                    </div>
                    <div class="form-group mt-3">
                        <label for="phone" class="form-label">Phone</label>
                        {!! Form::text('phone', null, ['class' => 'form-control', 'required' => 'required',
                        'placeholder' => '08123XXXX',]) !!}
                        <small class="text-danger">{{ $errors->first('phone') }}</small>
                    </div>
                    <div class="form-group mt-3">
                        <label for="password" class="form-label">Password</label>
                        {!! Form::password('password', ['class' => 'form-control']) !!}
                        <small class="text-danger">{{ $errors->first('password') }}</small>
                    </div>
                    {!! Form::submit($button, ['class' => 'btn btn-primary pull-right mt-3']) !!}
                    {!! Form::close() !!}
                </div>
            </div>
        </div>
    </div>

</x-app-layout>
