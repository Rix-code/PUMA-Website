<?php

namespace App\Models;

use App\Models\Members;
use App\Models\Categories;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class News extends Model
{
    /** @use HasFactory<\Database\Factories\NewsFactory> */
    use HasFactory;

    protected $fillable = ['title', 'content', 'image_url', 'author_id'];
    
    public function author() {
        return $this->belongsTo(Members::class, 'id');
    }

    public function category()
    {
        return $this->belongsTo(Categories::class, 'categories_id');
    }
}
