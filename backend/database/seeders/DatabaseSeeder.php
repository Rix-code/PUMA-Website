<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Database\Seeders\NewsSeeder;
use Database\Seeders\RolesSeeder;
use Database\Seeders\MembersSeeder;
use Database\Seeders\CabinetsSeeder;
use Database\Seeders\DivisionsSeeder;
use Database\Seeders\CategoriesSeeder;
use Database\Seeders\MemberDetailsSeeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            DivisionsSeeder::class,
            MembersSeeder::class,
            CabinetsSeeder::class,
            RolesSeeder::class,
            MemberDetailsSeeder::class,
            CategoriesSeeder::class,
            NewsSeeder::class,
        ]);
        User::factory()->create([
            'name' => 'Test User',
            'email' => 'test@example.com',
        ]);
    }
}
