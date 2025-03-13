<template>
    <div class="relative flex flex-col items-center justify-center min-h-screen overflow-hidden text-white bg-black">
        <div class="absolute inset-0 overflow-hidden">
            <div class="absolute w-full h-full bg-gradient-to-b from-black to-black/90"></div>
            <div class="absolute w-64 h-64 rounded-full bg-white/5 blur-3xl animate-pulse -top-20 -left-20"></div>
            <div class="absolute w-64 h-64 rounded-full bg-white/5 blur-3xl animate-pulse -bottom-20 -right-20"></div>
            <div
                class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGRlZnM+PHBhdHRlcm4gaWQ9ImdyaWQiIHdpZHRoPSI2MCIgaGVpZ2h0PSI2MCIgcGF0dGVyblVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHBhdGggZD0iTSA2MCAwIEwgMCAwIDAgNjAiIGZpbGw9Im5vbmUiIHN0cm9rZT0id2hpdGUiIHN0cm9rZS13aWR0aD0iMC41IiBzdHJva2Utb3BhY2l0eT0iMC4wNSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3Qgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgZmlsbD0idXJsKCNncmlkKSIvPjwvc3ZnPg==')] opacity-30">
            </div>
        </div>

        <div class="container relative z-10 px-4 py-4 mx-auto">
            <div class="max-w-2xl mx-auto text-center">
                <div
                    class="inline-block px-3 py-1 mb-4 font-mono text-xs font-bold uppercase rounded-full bg-white/10 backdrop-blur-sm animate-bounce">
                    <span class="mr-1 text-xs px-1.5 py-0.5 rounded-full bg-white/20">!</span>
                    404? More like 4-O-Fun! Let's GO!
                </div>

                <div class="flex items-center justify-center mb-6">
                    <div class="relative">
                        <div class="absolute inset-0 rounded-full bg-white/5 blur-lg"></div>
                        <span class="relative font-mono text-4xl font-bold tracking-wider sm:text-6xl">4</span>
                    </div>
                    <div class="relative mx-1 transition-transform duration-300 transform sm:mx-2 hover:scale-110">
                        <div class="absolute inset-0 rounded-full bg-white/20 blur-lg animate-pulse"></div>
                        <div
                            class="relative flex items-center justify-center w-12 h-12 p-1 bg-white rounded-full shadow-lg sm:w-16 sm:h-16">
                            <div class="text-sm font-bold text-black sm:text-lg">GAME</div>
                        </div>
                    </div>
                    <div class="relative">
                        <div class="absolute inset-0 rounded-full bg-white/5 blur-lg"></div>
                        <span class="relative font-mono text-4xl font-bold tracking-wider sm:text-6xl">4</span>
                    </div>
                </div>

                <!-- Game Container -->
                <div class="mx-auto mb-6">
                    <div class="p-4 border rounded-2xl bg-white/5 backdrop-blur-sm border-white/10">
                        <h1 class="mb-2 text-xl font-bold">Avoid the Dots</h1>
                        <p class="mb-3 font-mono text-xs text-white/70">
                            Use the arrow keys to avoid the falling red dots.
                        </p>
                        <div class="flex flex-col items-center">
                            <div id="gameContainer" class="relative">
                                <canvas id="gameCanvas" width="350" height="350"
                                    class="mx-auto border rounded-lg shadow-lg border-white/20"></canvas>
                                
                                <!-- Start Game Overlay -->
                                <div id="startGameOverlay" class="absolute inset-0 flex flex-col items-center justify-center rounded-lg bg-black/70">
                                    <div class="mb-4 text-xl font-bold">Ready to Play?</div>
                                    <button id="startGameBtn" 
                                        class="px-6 py-3 font-mono text-sm font-bold text-black transition-all duration-300 bg-white rounded-full hover:bg-white/90 hover:scale-105">
                                        START GAME
                                    </button>
                                </div>
                            </div>
                            
                            <div class="flex items-center justify-between w-full mt-3">
                                <div id="score" class="font-mono text-sm text-white/70">Score: 0</div>
                                <div class="flex items-center">
                                    <button id="muteBtn"
                                        class="flex items-center justify-center w-8 h-8 mr-2 border rounded-full bg-white/10 backdrop-blur-sm border-white/20 hover:bg-white/20">
                                        <span id="muteIcon" class="text-sm">🔊</span>
                                    </button>
                                    <button id="restartBtn"
                                        class="flex items-center justify-center px-3 py-1 font-mono text-xs border rounded-md bg-white/10 backdrop-blur-sm border-white/20 hover:bg-white/20">
                                        Restart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="flex justify-center mb-4">
                    <router-link to="/"
                        class="relative px-4 py-2 overflow-hidden font-mono text-xs font-medium uppercase transition-all duration-300 rounded-full sm:px-6 sm:py-3 group">
                        <span class="relative z-10 flex items-center text-black">
                            <span class="mr-2 text-xs px-1.5 py-0.5 rounded-full bg-black/20">01</span>
                            <span class="flex items-center transition-opacity duration-300 group-hover:opacity-0">
                                Return Home
                            </span>
                            <span
                                class="absolute right-0 flex items-center ml-6 font-bold text-red-500 transition-opacity duration-300 opacity-0 left-6 group-hover:opacity-100">
                                Nooo! 😭
                            </span>
                        </span>
                        <span
                            class="absolute inset-0 transition-all duration-300 bg-gradient-to-r from-white to-white/90 group-hover:translate-y-0 group-hover:translate-x-0 group-hover:scale-100"></span>
                    </router-link>
                </div>
            </div>
        </div>

        <!-- Mobile Controls - Fixed position at bottom of screen -->
        <div id="mobileControls" class="fixed left-0 right-0 z-20 hidden bottom-20">
            <div class="flex items-center justify-center">
                <div class="p-3 border shadow-lg bg-black/60 backdrop-blur-md rounded-2xl border-white/10">
                    <!-- Left side D-pad controls -->
                    <div class="grid grid-cols-3 gap-2">
                        <div></div>
                        <button id="upBtn"
                            class="flex items-center justify-center border rounded-lg w-14 h-14 bg-white/10 backdrop-blur-sm border-white/20 active:bg-white/20">
                            <span class="text-lg">▲</span>
                        </button>
                        <div></div>
                        <button id="leftBtn"
                            class="flex items-center justify-center border rounded-lg w-14 h-14 bg-white/10 backdrop-blur-sm border-white/20 active:bg-white/20">
                            <span class="text-lg">◀</span>
                        </button>
                        <div class="flex items-center justify-center w-14 h-14">
                            <div class="w-6 h-6 rounded-full bg-white/5"></div>
                        </div>
                        <button id="rightBtn"
                            class="flex items-center justify-center border rounded-lg w-14 h-14 bg-white/10 backdrop-blur-sm border-white/20 active:bg-white/20">
                            <span class="text-lg">▶</span>
                        </button>
                        <div></div>
                        <button id="downBtn"
                            class="flex items-center justify-center border rounded-lg w-14 h-14 bg-white/10 backdrop-blur-sm border-white/20 active:bg-white/20">
                            <span class="text-lg">▼</span>
                        </button>
                        <div></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Decorative Elements -->
        <div class="absolute w-10 h-1 rounded-full bottom-5 left-5 bg-white/30"></div>
        <div class="absolute w-1 h-10 rounded-full top-5 right-5 bg-white/30"></div>
        <div class="absolute w-2 h-2 rounded-full top-1/4 left-1/4 bg-white/50 animate-ping"></div>
        <div class="absolute w-2 h-2 delay-150 rounded-full bottom-1/4 right-1/4 bg-white/50 animate-ping"></div>

        <!-- Footer -->
        <div class="absolute bottom-0 left-0 right-0 z-10 py-2 text-center">
            <p class="font-mono text-xs text-white/50">© PUMA 2025. All rights reserved.</p>
        </div>
    </div>
</template>

<script setup lang="ts">
import { onMounted} from "vue";

onMounted(() => {
    const canvas = document.getElementById("gameCanvas") as HTMLCanvasElement;
    const ctx = canvas.getContext("2d")!;
    const scoreElement = document.getElementById("score") as HTMLElement;
    const mobileControls = document.getElementById("mobileControls") as HTMLElement;
    const muteBtn = document.getElementById("muteBtn") as HTMLElement;
    const muteIcon = document.getElementById("muteIcon") as HTMLElement;
    const restartBtn = document.getElementById("restartBtn") as HTMLElement;
    const startGameBtn = document.getElementById("startGameBtn") as HTMLElement;
    const startGameOverlay = document.getElementById("startGameOverlay") as HTMLElement;

    // Audio system
    let muted = false;

    // Create audio elements
    const sounds = {
        background: new Audio("https://cdn.freesound.org/previews/142/142608_1840739-lq.mp3"),
        collision: new Audio("https://cdn.freesound.org/previews/331/331912_3248244-lq.mp3"),
        point: new Audio("https://cdn.freesound.org/previews/404/404764_140737-lq.mp3"),
        gameOver: new Audio("https://cdn.freesound.org/previews/277/277021_5123851-lq.mp3")
    };

    // Configure background music
    sounds.background.loop = true;
    sounds.background.volume = 0.3;

    // Configure sound effects
    sounds.collision.volume = 0.4;
    sounds.point.volume = 0.2;
    sounds.gameOver.volume = 0.5;

    // Function to play a sound if not muted
    function playSound(sound: 'background' | 'collision' | 'point' | 'gameOver') {
        if (!muted) {
            // For background music, just make sure it's playing
            if (sound === 'background') {
                if (sounds.background.paused) {
                    try {
                        sounds.background.play().catch(e => console.log("Audio play failed:", e));
                    } catch (e) {
                        console.log("Could not play background audio:", e);
                    }
                }
                return;
            }

            // For other sounds, reset and play
            try {
                sounds[sound].currentTime = 0;
                sounds[sound].play().catch(e => console.log("Audio play failed:", e));
            } catch (e) {
                console.log("Could not play audio:", e);
            }
        }
    }

    // Toggle mute function
    function toggleMute() {
        muted = !muted;
        muteIcon.textContent = muted ? "🔇" : "🔊";

        // Stop or play background music accordingly
        if (muted) {
            sounds.background.pause();
        } else {
            try {
                sounds.background.play().catch(e => console.log("Audio play failed:", e));
            } catch (e) {
                console.log("Could not play background audio:", e);
            }
        }
    }

    // Add event listener to mute button
    muteBtn.addEventListener("click", toggleMute);

    // Show mobile controls if screen width is less than 768px
    function checkMobileView() {
        if (window.innerWidth < 768) {
            mobileControls.classList.remove("hidden");
            mobileControls.classList.add("flex");
        } else {
            mobileControls.classList.add("hidden");
            mobileControls.classList.remove("flex");
        }
    }

    // Check on load and when window resizes
    checkMobileView();
    window.addEventListener('resize', checkMobileView);

    // Game state
    const player = { x: 160, y: 300, size: 18 };
    let obstacles: Array<{ x: number; y: number; size: number }> = [];
    let gameRunning = false; // Changed to false initially
    let score = 0;
    let lastScoreIncrement = 0;
    let difficulty = 1;
    let lastTime = 0;
    let gameInitialized = false;

    // Apply canvas styling
    canvas.style.backgroundColor = "rgba(0, 0, 0, 0.3)";

    // Initial canvas setup with instructions
    function drawInitialScreen() {
        gameInitialized
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        drawGrid();
        
        // Draw player in starting position
        ctx.shadowBlur = 10;
        ctx.shadowColor = "rgba(255, 255, 255, 0.8)";
        ctx.fillStyle = "white";
        ctx.fillRect(player.x, player.y, player.size, player.size);
        ctx.shadowBlur = 0;
    }

    function drawPlayer() {
        // Draw glow effect
        ctx.shadowBlur = 10;
        ctx.shadowColor = "rgba(255, 255, 255, 0.8)";

        // Draw player
        ctx.fillStyle = "white";
        ctx.fillRect(player.x, player.y, player.size, player.size);

        // Reset shadow
        ctx.shadowBlur = 0;
    }

    function drawObstacles() {
        obstacles.forEach((obs) => {
            // Draw glow effect
            ctx.shadowBlur = 8;
            ctx.shadowColor = "rgba(255, 0, 0, 0.6)";

            // Draw obstacle with gradient
            const gradient = ctx.createRadialGradient(
                obs.x, obs.y, 0,
                obs.x, obs.y, obs.size
            );
            gradient.addColorStop(0, "rgba(255, 50, 50, 1)");
            gradient.addColorStop(1, "rgba(200, 0, 0, 0.8)");

            ctx.fillStyle = gradient;
            ctx.beginPath();
            ctx.arc(obs.x, obs.y, obs.size, 0, Math.PI * 2);
            ctx.fill();

            // Reset shadow
            ctx.shadowBlur = 0;
        });
    }

    function drawGrid() {
        // Draw a subtle grid background
        ctx.strokeStyle = "rgba(255, 255, 255, 0.05)";
        ctx.lineWidth = 0.5;

        // Vertical lines
        for (let x = 0; x <= canvas.width; x += 20) {
            ctx.beginPath();
            ctx.moveTo(x, 0);
            ctx.lineTo(x, canvas.height);
            ctx.stroke();
        }

        // Horizontal lines
        for (let y = 0; y <= canvas.height; y += 20) {
            ctx.beginPath();
            ctx.moveTo(0, y);
            ctx.lineTo(canvas.width, y);
            ctx.stroke();
        }
    }

    function updateObstacles() {
        // Move existing obstacles
        obstacles = obstacles.map((obs) => ({ ...obs, y: obs.y + (3 * difficulty) }));

        // Remove obstacles that went off screen
        obstacles = obstacles.filter((obs) => obs.y < canvas.height + obs.size);

        // Add new obstacles based on difficulty
        if (Math.random() < 0.02 * difficulty) {
            obstacles.push({
                x: Math.random() * (canvas.width - 20),
                y: -20,
                size: 8 + Math.random() * 8
            });
        }

        // Increase score and difficulty over time
        score += 1;

        // Play point sound every 100 points
        if (Math.floor(score / 100) > lastScoreIncrement) {
            lastScoreIncrement = Math.floor(score / 100);
            playSound('point');
        }

        if (score % 500 === 0 && difficulty < 2.5) {
            difficulty += 0.1;
        }

        scoreElement.textContent = `Score: ${score}`;
    }

    function checkCollision() {
        for (const obs of obstacles) {
            // Calculate distance between player center and obstacle center
            const playerCenterX = player.x + player.size / 2;
            const playerCenterY = player.y + player.size / 2;
            const dx = obs.x - playerCenterX;
            const dy = obs.y - playerCenterY;
            const distance = Math.sqrt(dx * dx + dy * dy);

            // Check if distance is less than the sum of radii (player is a square, so we approximate)
            const playerRadius = player.size / 2;
            if (distance < playerRadius + obs.size) {
                playSound('collision');
                gameOver();
                break;
            }
        }
    }

    function gameOver() {
        gameRunning = false;

        // Play game over sound
        sounds.background.pause();
        playSound('gameOver');

        // Draw game over screen
        ctx.fillStyle = "rgba(0, 0, 0, 0.7)";
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        ctx.fillStyle = "white";
        ctx.font = "24px monospace";
        ctx.textAlign = "center";
        ctx.fillText("GAME OVER", canvas.width / 2, canvas.height / 2 - 20);

        ctx.font = "16px monospace";
        ctx.fillText(`Final Score: ${score}`, canvas.width / 2, canvas.height / 2 + 20);

        ctx.font = "14px monospace";
        ctx.fillText("Tap to play again", canvas.width / 2, canvas.height / 2 + 50);

        // Add click event listener for restart
        canvas.addEventListener("click", restartGame);
        canvas.addEventListener("touchstart", restartGame);
    }

    function restartGame() {
        // Reset game state
        obstacles = [];
        gameRunning = true;
        score = 0;
        lastScoreIncrement = 0;
        difficulty = 1;
        player.x = 160;
        player.y = 300;

        // Hide the start overlay if it's still visible
        if (startGameOverlay) {
            startGameOverlay.style.display = "none";
        }

        // Remove event listeners
        canvas.removeEventListener("click", restartGame);
        canvas.removeEventListener("touchstart", restartGame);

        // Restart background music
        try {
            sounds.background.currentTime = 0;
            playSound('background');
        } catch (e) {
            console.log("Could not restart background audio:", e);
        }

        // Start the game loop again
        requestAnimationFrame(gameLoop);
    }

    function startGame() {
        // Hide the start overlay
        startGameOverlay.style.display = "none";
        
        // Start the game
        gameRunning = true;
        gameInitialized = true;
        
        // Play background music
        playSound('background');
        
        // Start the game loop
        requestAnimationFrame(gameLoop);
    }

    function gameLoop(timestamp: number) {
        if (!gameRunning) return;

        // Calculate time delta
        if (!lastTime) lastTime = timestamp;
        lastTime = timestamp;

        // Clear canvas
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        // Draw game elements
        drawGrid();
        drawPlayer();
        drawObstacles();

        // Update game state
        updateObstacles();
        checkCollision();

        // Continue loop
        requestAnimationFrame(gameLoop);
    }

    // Add restart button functionality
    restartBtn.addEventListener("click", () => {
        if (!gameRunning) return;
        gameOver();
        setTimeout(restartGame, 500);
    });

    // Add start game button functionality
    startGameBtn.addEventListener("click", startGame);

    // Keyboard controls
    window.addEventListener("keydown", (e) => {
        if (!gameRunning) return;

        const moveSize = 18; // Smaller movement increments for better control

        if (e.key === "ArrowLeft" && player.x > 0) {
            player.x = Math.max(0, player.x - moveSize);
        }
        if (e.key === "ArrowRight" && player.x < canvas.width - player.size) {
            player.x = Math.min(canvas.width - player.size, player.x + moveSize);
        }
        if (e.key === "ArrowUp" && player.y > 0) {
            player.y = Math.max(0, player.y - moveSize);
        }
        if (e.key === "ArrowDown" && player.y < canvas.height - player.size) {
            player.y = Math.min(canvas.height - player.size, player.y + moveSize);
        }
    });

    // Touch controls for mobile
    const upBtn = document.getElementById("upBtn");
    const downBtn = document.getElementById("downBtn");
    const leftBtn = document.getElementById("leftBtn");
    const rightBtn = document.getElementById("rightBtn");

    const moveSize = 18;

    function setupTouchControls(btn: HTMLElement | null, direction: string) {
        if (!btn) return;

        const handleMove = () => {
            if (!gameRunning) return;

            if (direction === "up" && player.y > 0) {
                player.y = Math.max(0, player.y - moveSize);
            } else if (direction === "down" && player.y < canvas.height - player.size) {
                player.y = Math.min(canvas.height - player.size, player.y + moveSize);
            } else if (direction === "left" && player.x > 0) {
                player.x = Math.max(0, player.x - moveSize);
            } else if (direction === "right" && player.x < canvas.width - player.size) {
                player.x = Math.min(canvas.width - player.size, player.x + moveSize);
            }
        };

        // Using both normal clicks and touch events
        btn.addEventListener("mousedown", () => {
            handleMove();
            const interval = setInterval(handleMove, 100);

            const stopMove = () => {
                clearInterval(interval);
                window.removeEventListener("mouseup", stopMove);
            };

            window.addEventListener("mouseup", stopMove);
        });

        btn.addEventListener("touchstart", (e) => {
            e.preventDefault(); // Prevent scrolling when touching the button
            handleMove();
            const interval = setInterval(handleMove, 100);

            const stopMove = () => {
                clearInterval(interval);
                window.removeEventListener("touchend", stopMove);
            };

            window.addEventListener("touchend", stopMove);
        });
    }

    setupTouchControls(upBtn, "up");
    setupTouchControls(downBtn, "down");
    setupTouchControls(leftBtn, "left");
    setupTouchControls(rightBtn, "right");

    // Draw the initial screen
    drawInitialScreen();
});
</script>