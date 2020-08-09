blue_on () {
    blueutil --connect 38-ec-0d-0c-3f-3a &
    blueutil --connect 60-83-73-93-c9-8e
}

blue_off () {
    blueutil --disconnect 38-ec-0d-0c-3f-3a &
    blueutil --disconnect 60-83-73-93-c9-8e
}
