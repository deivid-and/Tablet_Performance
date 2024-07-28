# run.spec
# -*- mode: python ; coding: utf-8 -*-

block_cipher = None

a = Analysis(
    ['run.py'],
    pathex=['.'],
    binaries=[],
    datas=[
        ('templates', 'templates'),
        ('static', 'static'),
        ('app/extensions.py', 'app/extensions.py')
    ],
    hiddenimports=[
        'werkzeug',
        'flask_socketio',
        'gevent',
        'gevent.monkey',
        'gevent.pool',
        'gevent.server',
        'gevent.socket',
        'gevent.ssl',
        'gevent.subprocess',
        'gevent.thread',
        'gevent.threading',
        'gevent.time',
        'geventwebsocket.handler',
        'geventwebsocket.server',
        'geventwebsocket.websocket',
        'socketio',
        'engineio'
    ],
    hookspath=[],
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
)
pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)
exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='run',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
)
coll = COLLECT(
    exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='run',
)
