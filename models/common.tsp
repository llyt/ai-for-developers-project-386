import "@typespec/http";

using Http;

namespace BookingApi;

/** E-mail адрес (RFC 5322). */
@format("email")
scalar email extends string;

/** Тело ответа об ошибке. */
model Error {
  /** Машиночитаемый код ошибки, напр. "not_found". */
  code: string;

  /** Человекочитаемое описание ошибки. */
  message: string;
}

/** Ресурс не найден. */
@error
model NotFoundError {
  @statusCode statusCode: 404;
  ...Error;
}

/** Конфликт: запрашиваемое время уже занято другой бронью. */
@error
model ConflictError {
  @statusCode statusCode: 409;
  ...Error;
}

/** Переданные данные не прошли валидацию. */
@error
model ValidationError {
  @statusCode statusCode: 422;
  ...Error;
}
