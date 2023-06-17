<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $data['model'] = User::latest()->paginate(10);
        return view('users.index', $data);
    }
    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $data = [
            'model' => new User(),
            'method' => 'POST',
            'route' => 'user.store',
            'button' => 'SIMPAN',
        ];

        return view('users.form', $data);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $reqData = $request->validate([
            'name' => 'required|min:3|max:255',
            'username' => 'required|min:3|max:255',
            'email' => 'required|email|unique:users,email|min:5|max:255',
            'phone' => 'required|unique:users,phone|min:11|max:14',
            'password' => 'required'
        ]);
        $reqData['password'] = bcrypt($reqData['password']);
        $reqData['email_verified_at'] = now();
        User::create($reqData);
        return redirect()->route('user.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $data = [
            'model' => User::findOrFail($id),
            'method' => 'PUT',
            'route' => ['user.update', $id],
            'button' => 'UPDATE',
        ];

        return view('users.form', $data);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $reqData = $request->validate([
            'name' => 'required|min:3|max:255',
            'username' => 'required|min:3|max:255',
            'email' => 'required|email|min:5|max:255|unique:users,email,' . $id,
            'phone' => 'required|min:11|max:14|unique:users,phone,' . $id,
            'password' => 'nullable'
        ]);
        $model = User::findOrFail($id);
        if ($reqData['password'] == "") {
            unset($reqData['password']);
        } else {
            $reqData['password'] = bcrypt($reqData['password']);
        }
        $model->fill($reqData);
        $model->save();
        return redirect()->route('user.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {

    }

    public function delete(Request $request){
        $berhasilDihapus = 0;
        $gagalDihapus = 0;
        $message = 'Data berhasil dihapus';

        for ($i = 0; $i < count($request->user_id); $i++) {
            $user = User::where('id', $request->user_id[$i])->first();
            if ($user != null) {
                    $user->delete();
                    $berhasilDihapus += 1;
            }
        }
        $message  = $message . ' : ' . $berhasilDihapus;
        if ($gagalDihapus > 0) {
            $message = $message . ' | Data gagal dihapus : ' . $gagalDihapus;
        }

        return response()->json([
            'message' => $message,
        ], 200);
    }
}
