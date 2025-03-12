<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class News extends Model
{
    /** @use HasFactory<\Database\Factories\NewsFactory> */
    use HasFactory;

    protected $fillable = ['title', 'content', 'image_url', 'author_id'];
    
    public function author() {
        return $this->belongsTo(Members::class, 'id');
    }
}
