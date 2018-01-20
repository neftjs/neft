package io.neft.extensions.ambientsound_extension;

import android.content.res.AssetFileDescriptor;
import android.media.MediaPlayer;
import android.view.View;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;

import java.io.IOException;

public class AmbientSoundItem extends NativeItem {
    final MediaPlayer mediaPlayer = new MediaPlayer();
    boolean prepared;
    boolean running;

    @OnCreate("AmbientSound")
    public AmbientSoundItem() {
        super(new View(APP.getWindowView().getContext()));

        mediaPlayer.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
            @Override
            public void onPrepared(MediaPlayer mediaPlayer) {
                prepared = true;
                setRunning(running);
            }
        });

        mediaPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
            @Override
            public void onCompletion(MediaPlayer mediaPlayer) {
                pushEvent("stop");
            }
        });
    }

    private void setStaticSource(String val) throws IOException {
        AssetFileDescriptor desc = APP.getActivity().getAssets().openFd(val.substring(1));
        mediaPlayer.setDataSource(desc.getFileDescriptor(), desc.getStartOffset(), desc.getLength());
    }

    private void setUnknownSource(String val) throws IOException {
        mediaPlayer.setDataSource(val);
    }

    @OnSet("source")
    public void setSource(String val) {
        mediaPlayer.reset();
        try {
            if (val.startsWith("/static")) {
                setStaticSource(val);
            } else {
                setUnknownSource(val);
            }
            mediaPlayer.prepareAsync();
        } catch (IOException error) {
            prepared = false;
            error.printStackTrace();
        }
    }

    @OnSet("loop")
    public void setLoop(boolean val) {
        mediaPlayer.setLooping(val);
    }

    @OnSet("running")
    public void setRunning(boolean val) {
        if (!prepared) return;
        if (mediaPlayer.isPlaying() == val) return;

        if (val) {
            mediaPlayer.start();
        } else {
            mediaPlayer.stop();
        }
    }
}
