# https://www.xataka.com/basics/como-mantener-tu-macbook-encendido-al-conectarlo-a-monitor-cerrar-tapa
{
  system.activationScripts.postActivation.text = ''
    sudo pmset -a sleep 0
    sudo pmset -a hibernatemode 0
    sudo pmset -a disablesleep 1
  '';
}
