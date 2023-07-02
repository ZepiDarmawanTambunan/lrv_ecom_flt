<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\ProductCategory;
use Illuminate\Http\Request;

class ProductCategoryController extends Controller
{
    public function all(Request $request)
    {
        $id = $request->input('id');
        $limit = $request->input('limit');
        $name = $request->input('name');
        $show_product = $request->input('show_product');

        if($id){
            $category = ProductCategory::with(['products'])->find($id);

            if($category){
                return ResponseFormatter::success($category, 'Data category product berhasil diambil');
            }else{
                return ResponseFormatter::error(null, 'Data category product gagal diambil', 404);
            }
        }

        $category = ProductCategory::query();

        if($name){
            $category->where('name', 'like', '%'.$name.'%');
        }

        if($show_product){
            $category->with('products');
        }

        if($category){
            return ResponseFormatter::success($category->paginate($limit), 'Data category product berhasil diambil');
        }else{
            return ResponseFormatter::error(null, 'Data category product gagal diambil', 404);
        }
    }

    public function store(Request $request){
        try {   
            $request->validate([
                'name' => 'required|string|unique:product_categories,name',
            ]);

            $productCategory = ProductCategory::create([
                'name' => $request->name,
            ]);
            return ResponseFormatter::success($productCategory, 'Tambah Category berhasil');
        } catch (\Throwable $error) {
            return ResponseFormatter::error([
                'message' => 'Something went wrong',
                'error' => $error->getMessage(),
            ],'Gagal', 500);
        }
    }
}
