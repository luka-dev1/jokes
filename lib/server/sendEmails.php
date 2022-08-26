<?php
$to = $_POST['recipients'];
$subject = 'Joke of the day';
$message = $_POST['content'];
$headers = 'From: luka.devel@egmail.com' . "\r\n" .
           'Reply-To: luka.devel@gmail.com' . "\r\n" .
           'X-Mailer: PHP/' . phpversion();

if(mail($to, $subject, $message, $headers)) {
    $result = 'Success';
} else {
    $result = 'Failure: Email was not sent!';
}

echo json_encode(['success' => $result]);
?>