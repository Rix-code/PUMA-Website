<script setup>
import { ContainerScroll } from '../components/ui/container-scroll';
</script>

<template>
    <div class="flex flex-col overflow-hidden">
        <ContainerScroll>
            <template #title>
                <h1 class="text-4xl font-semibold text-black dark:text-white">
                    Unleash the power of <br />
                    <span class="mt-1 text-4xl font-bold leading-none md:text-[6rem]">
                        PUMA
                    </span>
                </h1>
            </template>
            <template #card>
                <img src="../../public/puma-bag.JPG" class="object-cover object-left-top h-full mx-auto rounded-2xl"
                    alt="hero" height="720" width="1400" />
            </template>
        </ContainerScroll>
    </div>
</template>
