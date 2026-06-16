import "./common.tsp";

namespace BookingApi;

/** Статус брони. */
enum BookingStatus {
  /** Подтверждена (выставляется автоматически при создании). */
  confirmed,

  /** Отменена. */
  cancelled,
}

/**
 * Бронирование — гость занимает конкретное время под выбранный тип события.
 * Создаётся гостем и сразу подтверждается (автоподтверждение).
 */
model Booking {
  /** Идентификатор брони. */
  @key id: string;

  /** Тип события, на который записан гость. */
  eventTypeId: string;

  /** Имя гостя. */
  guestName: string;

  /** E-mail гостя. */
  guestEmail: email;

  /** Начало встречи (UTC, ISO 8601). */
  start: utcDateTime;

  /** Конец встречи (UTC, ISO 8601); вычисляется из длительности типа. */
  end: utcDateTime;

  /** Текущий статус брони. */
  status: BookingStatus;

  /** Момент создания брони (UTC, ISO 8601). */
  createdAt: utcDateTime;
}

/**
 * Данные для создания брони.
 * `end`, `status` и `createdAt` вычисляются сервером.
 */
model BookingCreate {
  /** Выбранный тип события. */
  eventTypeId: string;

  /** Начало выбранного слота (UTC, ISO 8601). */
  start: utcDateTime;

  /** Имя гостя. */
  guestName: string;

  /** E-mail гостя. */
  guestEmail: email;
}
