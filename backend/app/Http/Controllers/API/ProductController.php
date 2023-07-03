<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\ProductCategory;
use App\Models\Product;
use App\Models\ProductGallery;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function all(Request $request)
    {
        $id = $request->input('id');
        $limit = $request->input('limit');
        $name = $request->input('name');
        $description = $request->input('description');
        $tags = $request->input('tags');
        $categories = $request->input('categories');

        $price_from = $request->input('price_from');
        $price_to = $request->input('price_to');

        if($id){
            $product = Product::with(['category', 'galleries'])->find($id);

            if($product){
                return ResponseFormatter::success($product, 'Data produk berhasil diambil');
            }else{
                return ResponseFormatter::error(null, 'Data produk gagal diambil', 404);
            }
        }

        $product = Product::with(['category', 'galleries']);

        if($name){
            $product->where('name', 'like', '%'.$name.'%');
        }

        if($description){
            $product->where('description', 'like', '%'.$description.'%');
        }

        if($tags){
            $product->where('tags', 'like', '%'.$tags.'%');
        }

        if($price_from){
            $product->where('price', '>=', $price_from);
        }

        if($price_to){
            $product->where('price', '<=', $price_to);
        }

        if($categories){
            $product->where('categories', $categories);
        }

        if($product){
            return ResponseFormatter::success($product->paginate($limit), 'Data produk berhasil diambil');
        }else{
            return ResponseFormatter::error(null, 'Data produk gagal diambil', 404);
        }
    }

    public function store(Request $request){
        try {
            $request->validate([
                'name' => 'required|string|unique:product_categories,name',
                'description' => 'required|string|min:3',
                'price' => 'required|numeric',
                'categories_id' => 'required|integer|exists:product_categories,id',
                'tags' => 'required|string',
                'images.*' => 'image|mimes:jpeg,png,jpg'
            ]);

            $product = Product::create([
                'name' => $request->name,
                'description' => $request->description,
                'price' => $request->price,
                'categories_id' => $request->categories_id,
                'tags' => $request->tags,
            ]);

            $productGalleries = [];
            if ($request->hasFile('images')) {
                foreach ($request->file('images') as $image) {
                    $fileName = $image->hashName();
                    $image->storeAs('public/product_images', $fileName);
                    $productGallery = ProductGallery::create([
                        'products_id' => $product->id,
                        'url' => $fileName,
                    ]);
                    $productGalleries[] = $productGallery;
                }
            }
            $product['galleries'] = $productGalleries;
            $product['category'] = $product->category;
            return ResponseFormatter::success($product, 'Tambah Category berhasil');
        } catch (\Throwable $error) {
            return ResponseFormatter::error([
                'message' => 'Something went wrong',
                'error' => $error->getMessage(),
            ],'Gagal', 500);
        }
    }
}
