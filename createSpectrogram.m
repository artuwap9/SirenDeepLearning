function createSpectrogram(mat)
    spectrogram(mat,100,90,100,22050,'yaxis');
    colorbar off
    view(180,-90)
    shading interp
    colormap(jet)
    axis off
end